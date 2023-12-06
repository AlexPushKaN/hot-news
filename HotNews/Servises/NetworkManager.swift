//
//  NetworkManager.swift
//  HotNews
//
//  Created by Александр Муклинов on 05.12.2023.
//

import Foundation

class NetworkManager {
    
    func getJSONData(for urlString: String, completionHandler: @escaping (NewsResponse) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("22e768a3d46c4d9ebbf248cf9efae0ce", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil, (response as! HTTPURLResponse).statusCode == 200 {
                
                let decoder = JSONDecoder()
                if let data = data {
                    
                    do {
                        
                        let JSONData = try decoder.decode(NewsResponse.self, from: data)
                        DispatchQueue.main.async { completionHandler(JSONData) }
                        
                    } catch { print("JSON parsing error: \(error)") }
                }
            } else { print(error?.localizedDescription ?? (response as! HTTPURLResponse).statusCode) }
        }.resume()
    }
}
