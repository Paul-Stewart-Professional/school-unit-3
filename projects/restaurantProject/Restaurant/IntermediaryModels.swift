//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Paul Stewart on 12/20/23.
//  Copyright © 2023 Paul Stewart. All rights reserved.
//

// Correspond to keys returned by the API under categories
struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
