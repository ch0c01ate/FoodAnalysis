//
//  NetworkManager.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 18.12.2020.
//

import Foundation

class NetworkManager {
    private static let appId = "e5f244a7"
    private static let appKey = "d7b952e1765ddb817cd6920c64d8644d"
    private static let nutritionAnalysisUrlEndpoint = "https://api.edamam.com/api/nutrition-data"
    
    enum Issue : Error {
        case noValue
        case system(Error)
    }
    
    static func parse(text: String, completion: ((Result<Nutrition, Issue>) -> Void)? = nil){
        
        let queryItems = [URLQueryItem(name: "app_id", value: appId), URLQueryItem(name: "app_key", value: appKey), URLQueryItem(name: "ingr", value: text)]
        var urlComps = URLComponents(string: nutritionAnalysisUrlEndpoint)!
        urlComps.queryItems = queryItems
        let url = urlComps.url!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            DispatchQueue.main.async {

                if let error = error {
                    completion?(.failure(Issue.system(error)))
                    return
                }

                guard let data = data else {
                    completion?(.failure(Issue.noValue))
                    return
                }

                do {
                    print(String(data: data, encoding: .utf8))
                    let answer = try JSONDecoder().decode(Nutrition.self, from: data)
                    print("decoded")
                    completion?(.success(answer))
                } catch {
                    print(error)
                    completion?(.failure(Issue.system(error)))
                }

            }

        }

        task.resume()
    }
}
