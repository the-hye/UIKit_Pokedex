//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by JIHYE SEOK on 7/8/24.
//

import Foundation

class PokemonAPI {
    static let baseURL = "https://pokeapi.co/api/v2/"
    
    static func fetchPokemonList(completion: @escaping (PokemonList?) -> Void) {
        guard let url = URL(string: baseURL + "pokemon?limit=10000&offset=0") else { return }
        
        // dataTask는 비동기 방식으로 메인 스레드를 방해하지 않는다.
        URLSession.shared.dataTask(with: url) { data, _, error  in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                completion(pokemonList)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        .resume()
    }
}
