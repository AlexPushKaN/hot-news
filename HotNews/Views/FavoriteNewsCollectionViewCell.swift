//
//  FavoriteNewsCollectionViewCell.swift
//  HotNews
//
//  Created by Александр Муклинов on 12.12.2023.
//

import UIKit

class FavoriteNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsPublicationDateLabel: UILabel!
    @IBOutlet weak var newsLikeImageView: UIImageView!
    @IBOutlet weak var newsHeadlineLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    var news: News!
    var delegate: UpdateListFavoriteNewsDelegate?
    
    func configure(news: News, listFavoriteNews: UpdateListFavoriteNewsDelegate) {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        self.news = news
        self.delegate = listFavoriteNews
        newsImageView.layer.cornerRadius = 10.0
        newsImageView.layer.masksToBounds = true
        let gestureTapLike = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        newsLikeImageView.addGestureRecognizer(gestureTapLike)
        newsPublicationDateLabel.text = news.publishedAt
        updateNewsLike()
        newsHeadlineLabel.text = news.title
        newsTextLabel.text = news.content
    }
    
    @objc func tapLike() {
        LikeNewsManager.shared.toggleLike(news: news)
        delegate?.favoriteNews = LikeNewsManager.shared.getLikedNews()
        updateNewsLike()
    }
    
    private func updateNewsLike() {
        if LikeNewsManager.shared.isLiked(news) { newsLikeImageView.isHighlighted = true }
        else { newsLikeImageView.isHighlighted = false }
    }
}
