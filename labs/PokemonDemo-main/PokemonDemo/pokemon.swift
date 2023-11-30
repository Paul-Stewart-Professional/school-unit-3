//
//  pokemon.swift
//  PokemonDemo
//
//  Created by Paul Stewart on 11/29/23.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let imageString: String
    
    enum CodingKeys: CodingKey {
        case name
        case sprites
    }
    enum SpriteCodingKeys: CodingKey {
        case other
    }
    enum OtherCodingKeys: String, CodingKey {
        case offcialArtwork = "official-artwork"
    }
    enum OfficialArtworkKeys: String, CodingKey {
        case frontDefault = "front_default  "
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        let spritesContainer = try container.nestedContainer(keyedBy: SpriteCodingKeys.self, forKey: .sprites)
        
        let otherContainer = try
        spritesContainer.nestedContainer(keyedBy: OtherCodingKeys.self, forKey: .other)
        
        let officialArtworkContainer = try
        otherContainer.nestedContainer(keyedBy: OfficialArtworkKeys.self, forKey: .offcialArtwork)
        
        imageString = try officialArtworkContainer.decode(String.self, forKey: .frontDefault)
    }
}

extension Pokemon {
    var imageURL: URL {
        URL(string: imageString)!
    }
}
