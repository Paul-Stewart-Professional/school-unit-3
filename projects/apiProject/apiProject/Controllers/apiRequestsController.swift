//
//  Rep Controller.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case non200StatusCode
}
enum DogError: Error, LocalizedError {
    case dogNumberError
    case imageData
}

struct APIRequestsController {
    static var baseURL = ""
    static let decoder = JSONDecoder()
    static let session = URLSession.shared
    
    static func fetchRequest(url: URLComponents) async throws -> Data {
        let request = URLRequest(url: url.url!)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.non200StatusCode
        }
        return data
    }
    
    static func fetchRep(zip: String) async throws -> RepresentativeResults {
        baseURL = "https://whoismyrepresentative.com/getall_mems.php"
        var url = URLComponents(string: baseURL)!
        url.queryItems = [
            URLQueryItem(name: "zip", value: zip),
            URLQueryItem(name: "output", value: "json")
        ]
        let data = try await fetchRequest(url: url)
        let rep = try decoder.decode(RepresentativeResults.self, from: data)
        return rep
    }
    
    static func fetchDogs(numberOfDogs: Int) async throws -> Dog {
        guard numberOfDogs >= 1 else { throw DogError.dogNumberError }
        baseURL = "https://dog.ceo/api/breeds/image/random"
        baseURL.append("/\(numberOfDogs)")
        var url = URLComponents(string: baseURL)!
        let data = try await fetchRequest(url: url)
        let dog = try decoder.decode(Dog.self, from: data)
        return dog
    }
}
