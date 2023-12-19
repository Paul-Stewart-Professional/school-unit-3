//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Paul Stewart on 12/19/23.
//

import Foundation

struct StoreItem: Codable {
    var kind: String
    var artWorkUrl: String
    var artistName: String
    var trackName: String
    var primaryGenreName: String
    var description: String?
    
    
    enum CodingKeys: String, CodingKey {
        case kind
        case artWorkUrl = "artworkUrl100"
        case artistName
        case trackName
        case primaryGenreName
        case description
    }
    enum AdditionalCodingKeys: CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artWorkUrl = try values.decode(String.self, forKey: CodingKeys.artWorkUrl)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        primaryGenreName = try values.decode(String.self, forKey: CodingKeys.primaryGenreName)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalCodingKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalCodingKeys.longDescription)) ?? ""
        }
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}
