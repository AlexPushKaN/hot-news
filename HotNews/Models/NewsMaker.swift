//
//  News.swift
//  HotNews
//
//  Created by Александр Муклинов on 05.12.2023.
//

import Foundation

class NewsMaker {
    
    let networkManager = NetworkManager()

    func getNews(from country: CountryCode, with category: CategoryCode, completionHandler: @escaping ([News]) -> Void) {
        
        networkManager.getJSONData(for: "https://newsapi.org/v2/top-headlines?country=\(country.rawValue)&category=\(category.rawValue)") { newsResponse in
            
            var allNews: [News] = []
            
            for news in newsResponse.articles {
                
                let news = News(title: news.title ?? "Без названия",
                                url: news.url ?? "Без источника",
                                urlToImage: news.urlToImage ?? "Без картинки",
                                publishedAt: news.publishedAt ?? "Без даты публикации",
                                content: news.content ?? "Без контента",
                                isLiked: false)
                allNews.append(news)
            }
            
            DispatchQueue.main.async { completionHandler(allNews) }
        }
    }
}
