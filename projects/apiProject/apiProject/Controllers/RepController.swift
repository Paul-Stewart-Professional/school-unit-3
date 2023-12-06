//
//  RepController.swift
//  apiProject
//
//  Created by Paul Stewart on 12/5/23.
//

import Foundation

class RepController {
    static let shared = RepController()
    
    var repNames = [Representative]()
    
    func fetchReps(zip: String) async throws -> [Representative] {
        let rep = try await APIRequestsController.fetchRep(zip: zip)
        return rep
    }
}

