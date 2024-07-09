//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by JIHYE SEOK on 7/8/24.
//

import Foundation

class PokemonAPI {
    static let shared = PokemonAPI()
    
    func fetchPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=10000&offset=0"
        performRequest(with: urlString, decodingType: PokemonList.self, completion: completion)
    }
    
    func fetchPokemonDetail(url: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        performRequest(with: url, decodingType: Pokemon.self, completion: completion)
    }
    
    private func performRequest<T: Decodable>(with urlString: String, decodingType: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
