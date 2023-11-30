//
//  starwarsPeopleController.swift
//  apiPractice
//
//  Created by Paul Stewart on 11/30/23.
//

import Foundation

enum StarwarsError: Error, LocalizedError {
    case non200ErrorCode
}

struct StarwarsPeopleController {
    static var baseURL = "https://swapi.dev/api/"
    static func getAllPeople() async throws -> StarwarsPeopleResult {
        let url = URLComponents(string: "\(baseURL)/people")!
        let session = URLSession.shared
        let request = URLRequest(url: url.url!)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw StarwarsError.non200ErrorCode
        }
        let decoder = JSONDecoder()
        let people = try decoder.decode(StarwarsPeopleResult.self, from: data)
        return people
    }
}
