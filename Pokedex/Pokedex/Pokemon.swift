//
//  Pokemon.swift
//  Pokedex
//
//  Created by JIHYE SEOK on 7/8/24.
//

import Foundation

// MARK: - 포케몬 리스트(https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0)
struct PokemonList: Codable {
    var count: Int
    var previous: String?
    var next: String?
    var results: [PokemonListObject]
}

struct PokemonListObject: Codable {
    var name: String
    var url: String
}

// MARK: - 포케몬 기본정보(https://pokeapi.co/api/v2/pokemon-form/1/)
struct Pokemon: Codable {
    let id: Int
    let name: String
    let spirites: Spirites
}

struct Spirites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
