//
//  SelectNewsViewController.swift
//  HotNews
//
//  Created by Александр Муклинов on 06.12.2023.
//

import UIKit
import SafariServices

class DetailNewsViewController: UIViewController {
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLink))
        newsTextLabel.isUserInteractionEnabled = true
        newsTextLabel.addGestureRecognizer(tapGesture)
        newsTextLabel.attributedText = createLinkIn(content: news.content)
    }

    private func updateNewsLike() {
        if LikeNewsManager.shared.isLiked(news) { newsLikeImageView.isHighlighted = true }
        else { newsLikeImageView.isHighlighted = false }
    }
    
    private func createLinkIn(content: String) -> NSAttributedString {
        var formattedString: String = ""
        if let range = content.range(of: "… [") {
            formattedString = String(content.prefix(upTo: range.lowerBound))
        }
        let attributedString = NSMutableAttributedString(string: formattedString)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let additionalText = NSAttributedString(string: " ...подробнее в источнике>>", attributes: attributes)
        attributedString.append(additionalText)
        return attributedString
    }
    
    @objc func tapLike() {
        LikeNewsManager.shared.toggleLike(news: news)
        updateNewsLike()
    }
    
    @objc func didTapLink() {
        if let url = URL(string: news.url) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
