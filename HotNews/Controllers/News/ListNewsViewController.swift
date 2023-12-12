//
//  ViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 05.12.2023.
//

import UIKit

class ListNewsViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!

    let newsMaker: NewsMaker = NewsMaker()
    var news: [News] = [] {
        didSet {
            newsCollectionView.reloadData()
        }
    }
    
    lazy var cachedDataSourse: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsMaker.getNews(from: .unitedStates, with: .technology) {
            self.news = $0
            LikeNewsManager.shared.newsMaker = self.newsMaker
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsCollectionView.reloadData()
    }
}

//MARK: - Method of obtaining and caching images for cells
extension ListNewsViewController {
    
    private func getImage(from urlString: String, by indexPath: IndexPath, inObject: UICollectionView) -> UIImage {
        var picture: UIImage = UIImage()
        if let image = cachedDataSourse.object(forKey: news[indexPath.item].id as AnyObject) { picture = image }
        else if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error { print("Error: \(error.localizedDescription)") }
                else {
                    DispatchQueue.main.async {
                        if let data = data {
                            if let image = UIImage(data: data) {
                                picture = image
                                inObject.reloadItems(at: [indexPath])
                                self.cachedDataSourse.setObject(image, forKey: self.news[indexPath.item].id as AnyObject)
                            }
                        }
                    }
                }
            }.resume()
        } else {
            picture = UIImage(named: "noImage")!
            self.cachedDataSourse.setObject(picture, forKey: self.news[indexPath.item].id as AnyObject)
        }
        return picture
    }
}

//MARK: - UICollectionViewDataSource
extension ListNewsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellNews", for: indexPath) as! NewsCollectionViewCell
        cell.configure(news: news[indexPath.item])
        cell.newsImageView.image = getImage(from: news[indexPath.item].urlToImage, by: indexPath, inObject: collectionView)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListNewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "selectNewsViewController") as! SelectNewsViewController
        controller.news = news[indexPath.item]
        controller.picture = cachedDataSourse.object(forKey: news[indexPath.item].id as AnyObject)
        navigationController?.pushViewController(controller, animated: true)
    }
}
