//
//  Reps.swift
//  apiProject
//
//  Created by Paul Stewart on 12/1/23.
//

import Foundation

struct Representative: Codable {
    var name: String
    var party: String
    var state: String
    var link: String
}


struct RepresentativeResults: Codable {
    var results: [Representative]
}
