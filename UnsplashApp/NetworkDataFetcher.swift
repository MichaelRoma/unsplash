//
//  NetworkDataFetcher.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 25.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation


class NetworkDataFetcher {

    var networkService = NetworkService()

    func fetchImages(searchType: SearchType, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchType: searchType) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }

            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }

    func getListTopics(completion: @escaping (ListTopicsResults?) -> ()) {
        networkService.request(searchType: .topics) { (data, error) in

            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }

            let decode = self.decodeJSON(type: ListTopicsResults.self, from: data)
            completion(decode)
        }
    }

    func getImagesFromTopics(idTopics: String, completion: @escaping (TopicsImagesResult?) -> ()) {

        networkService.request(searchType: .topicsImages(id: idTopics)) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: TopicsImagesResult.self, from: data)
            completion(decode)
        }
    }

    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }

        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }


}
