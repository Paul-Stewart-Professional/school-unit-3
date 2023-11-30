//
//  starwarsPeopleResult.swift
//  apiPractice
//
//  Created by Paul Stewart on 11/30/23.
//

import Foundation

struct StarwarsPeopleResult: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [People]
}
