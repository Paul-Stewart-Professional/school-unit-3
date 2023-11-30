//
//  PokemonController.swift
//  PokemonDemo
//
//  Created by Paul Stewart on 11/29/23.
//

import Foundation

enum PokemonError: Error {
    case badResponse
}

class PokemonController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //fetch pokemon
    func fetchPokemon(with id: String) async throws -> Pokemon {
        let url = baseURL.appending(path: id)
            let (data, response) = try await
                URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw PokemonError.badResponse
            }
        let jsonDecoder = JSONDecoder()
        let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
        return pokemon
    }
    //fetch image
    //fetch image
    func fetchImageData(for url: URL) async throws -> Data {
        let (data, response) = try await
            URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw PokemonError.badResponse
        }
        return data
    }
}
