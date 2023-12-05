//
//  DogController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/4/23.
//

import Foundation

class DogController {
    
    static let shared = DogController()
    
    var imageURLs = [URL]()
    
    func fetchDogs(count: Int) async throws -> [URL] {
        let dog = try await APIRequestsController.fetchDogs(numberOfDogs: count)
        imageURLs = dog.imageURLs
        return dog.imageURLs
    }
    
}
