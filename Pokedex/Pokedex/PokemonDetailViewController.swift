//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by JIHYE SEOK on 7/9/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonURL: String
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    init(pokemonURL: String) {
        self.pokemonURL = pokemonURL
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPokemonDetails()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 100),
//            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        ])
    }
    
    private func fetchPokemonDetails() {
        PokemonAPI.shared.fetchPokemonDetail(url: pokemonURL) { [weak self] result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self?.updateUI(with: pokemon)
                }
            case .failure(let error):
                print("Error fetching pokemon detail - \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        
        if let url = URL(string: pokemon.sprites.frontDefault) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
            .resume()
        }
    }
}



#Preview {
    return UINavigationController(rootViewController: PokemonDetailViewController(pokemonURL: "https://pokeapi.co/api/v2/pokemon/1/"))
}
