//
//  people.swift
//  apiPractice
//
//  Created by Paul Stewart on 11/30/23.
//

import Foundation

struct People: Decodable {
    var name: String
    var height: String
    var mass: String
    var hair_color: String
    var skin_color: String
    var eye_color: String
    var birth_year: String
}
