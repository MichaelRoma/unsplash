//
//  NetworkService.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 25.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

enum SearchType {
    case photos(searchTerm: String)
    case random
    case topics
    case topicsImages(id: String)

    var typeName: String {
        switch self {
        case .photos:
            return "/search/photos"
        case .random:
            return "/photos/random"
        case .topics :
            return "/topics"
        case .topicsImages (let id):
            return "/topics/:\(id)/photos"
        }
    }
}

class NetworkService {

    // построение запроса данных по URL
    func request(searchType: SearchType, completion: @escaping (Data?, Error?) -> Void)  {

        let parameters = self.prepareParaments(searchType: searchType)
        let url = self.url(searchType: searchType.typeName, params: parameters)

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID Qy2zCD4_4BeQsxP1zYvZwp_ByovjR3rQXjjFMbAelkI"
        return headers
    }

    private func prepareParaments(searchType: SearchType) -> [String: String] {

        var parameters = [String: String]()

        switch searchType {
        case .photos (let searchTerm):
            parameters["query"] = searchTerm
            parameters["page"] = String(1)
            parameters["per_page"] = String(30)
            parameters["order_by"] = String(UserDefaults.standard.getOrderRequest())

        case .random:
            parameters["count"] = String(30)
            
        case .topics:
            parameters["order_by"] = "latest"

        case .topicsImages (let id):
            
            parameters["id_or_slug"] = id
//            parameters["page"] = String(1)
//            parameters["per_page"] = String(30)
//            parameters["order_by"] = "popular"

            //https://api.unsplash.com/topics/:dijpbw99kQQ/photos?page=530
        }

        return parameters
    }

    private func url(searchType: String,  params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = searchType
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
