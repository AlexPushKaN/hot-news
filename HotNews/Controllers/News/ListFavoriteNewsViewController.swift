//
//  ListFavoriteNewsViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 11.12.2023.
//

import UIKit

protocol UpdateListFavoriteNewsDelegate {
    
    var favoriteNews: [News] { get set }
}

class ListFavoriteNewsViewController: UIViewController, UpdateListFavoriteNewsDelegate {

    @IBOutlet weak var favoriteNewsCollectionView: UICollectionView!

    var favoriteNews: [News] = [] {
        didSet {
            favoriteNewsCollectionView.reloadData()
        }
    }
    
    lazy var cachedDataSourse: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteNewsCollectionView.dataSource = self
        favoriteNewsCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoriteNews = LikeNewsManager.shared.getLikedNews()
    }
}

//MARK: - Method of obtaining and caching images for cells
extension ListFavoriteNewsViewController {
    
    private func getImage(from urlString: String, by indexPath: IndexPath, inObject: UICollectionView) -> UIImage {
        var picture: UIImage = UIImage()
        if let image = cachedDataSourse.object(forKey: self.favoriteNews[indexPath.item].id as AnyObject) { picture = image }
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
                                self.cachedDataSourse.setObject(image, forKey: self.favoriteNews[indexPath.item].id as AnyObject)
                            }
                        }
                    }
                }
            }.resume()
        } else {
            picture = UIImage(named: "noImage")!
            self.cachedDataSourse.setObject(picture, forKey: self.favoriteNews[indexPath.item].id as AnyObject)
        }
        return picture
    }
}

//MARK: - UICollectionViewDataSource
extension ListFavoriteNewsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return favoriteNews.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavoriteNews", for: indexPath) as! FavoriteNewsCollectionViewCell
        cell.configure(news: favoriteNews[indexPath.item], listFavoriteNews: self)
        cell.newsImageView.image = getImage(from: favoriteNews[indexPath.item].urlToImage, by: indexPath, inObject: collectionView)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListFavoriteNewsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "detailNewsViewController") as! DetailNewsViewController
        controller.news = favoriteNews[indexPath.item]
        controller.picture = cachedDataSourse.object(forKey: self.favoriteNews[indexPath.item].id as AnyObject)
        navigationController?.pushViewController(controller, animated: true)
    }
}
