//
//  SelectNewsViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 06.12.2023.
//

import UIKit

class SelectNewsViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsLikeImageView: UIImageView!
    @IBOutlet weak var newsPublicationDateLabel: UILabel!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var news: News!
    var picture: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsImageView.layer.cornerRadius = 10.0
        newsImageView.clipsToBounds = true
        newsImageView.image = picture
        
        let gestureTapLike = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        newsLikeImageView.addGestureRecognizer(gestureTapLike)
        updateNewsLike()
        
        newsPublicationDateLabel.text = news.publishedAt
        newsHeadlineLabel.text = news.title
        newsTextLabel.text = news.content
    }
    
    @objc func tapLike() {
        
        LikeNewsManager.shared.toggleLike(news: news)
        updateNewsLike()
    }
    
    private func updateNewsLike() {
        
        if LikeNewsManager.shared.isLiked(news) { newsLikeImageView.isHighlighted = true }
        else { newsLikeImageView.isHighlighted = false }
    }
}
