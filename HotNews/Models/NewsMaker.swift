//
//  News.swift
//  HotNews
//
//  Created by Александр Муклинов on 05.12.2023.
//

import Foundation

class NewsMaker {
    
    let networkManager = NetworkManager()
    var userEntity: UserEntity = { return CoreDataManager.shared.getUserEntity(userID: UserProfile.shared.id) }()
    lazy var favoriteNews: [News] = getFavoriteNews(from: CoreDataManager.shared.getFavorite(newsFor: userEntity))

    func getNews(from country: CountryCode, with category: CategoryCode, completionHandler: @escaping ([News]) -> Void) {
        networkManager.getJSONData(for: "https://newsapi.org/v2/top-headlines?country=\(country.rawValue)&category=\(category.rawValue)") { newsResponse in
            var allNews: [News] = []
            for news in newsResponse.articles {
                var news = News(id: UUID().uuidString,
                                title: news.title ?? "Без названия",
                                url: news.url ?? "Без источника",
                                urlToImage: news.urlToImage ?? "Без картинки",
                                publishedAt: self.converter(dateString: news.publishedAt ?? ""),
                                content: news.content ?? "Без контента",
                                isLiked: false)
                self.favoriteNews.forEach { [weak self] favoriteNews in
                    guard let self = self else { return }
                    if favoriteNews.url == news.url {
                        news.id = favoriteNews.id
                        self.favoriteNews.remove(at: self.favoriteNews.firstIndex(of: favoriteNews)!)
                        self.favoriteNews.append(news)
                    }
                }
                allNews.append(news)
            }
            DispatchQueue.main.async { completionHandler(allNews) }
        }
    }
    
    private func getFavoriteNews(from data: [NewsEntity]) -> [News] {
        return data.compactMap { newsEntity in
            guard let id = newsEntity.id,
                  let title = newsEntity.title,
                  let url = newsEntity.url,
                  let urlToImage = newsEntity.urlToImage,
                  let publishedAt = newsEntity.publishedAt,
                  let content = newsEntity.content else {
                return nil
            }
            return News(id: id,
                        title: title,
                        url: url,
                        urlToImage: urlToImage,
                        publishedAt: publishedAt,
                        content: content,
                        isLiked: true)
        }
    }
    
    private func converter(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return "Без даты публикации"}
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
}
