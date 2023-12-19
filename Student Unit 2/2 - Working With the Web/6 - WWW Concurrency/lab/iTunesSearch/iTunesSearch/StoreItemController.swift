//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Paul Stewart on 12/19/23.
//

import Foundation
import UIKit

class StoreItemController {

    enum error: Error, LocalizedError {
        case non200StatusCode
    }

    func fetchItems(matching query: [String: String]) async throws -> [StoreItem] {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map( { URLQueryItem(name: $0.key, value: $0.value ) } )
        let (data, response) = try await
        URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw error.non200StatusCode}
        let jsonDecoder = JSONDecoder()
        let searchRequest = try jsonDecoder.decode(SearchResponse.self, from: data)
        return searchRequest.results
    }
    
    public func getImageData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
