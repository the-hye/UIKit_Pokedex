//
//  ViewController.swift
//  Pokedex
//
//  Created by JIHYE SEOK on 7/8/24.
//

import UIKit

class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonList: [PokemonListObject] = []
    
    private let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPokemonList()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        title = "Pokedex"
    }
    
    // MARK: - Methods
    private func fetchPokemonList() {
        PokemonAPI.shared.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.pokemonList = pokemonList.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching pokemon list - \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - UIViewDateSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonList[indexPath.row]
        cell.textLabel?.text = "\(pokemon.name.capitalized)"
        return cell
    }
    
    //MARK: - UIViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row]
        let detailViewController = PokemonDetailViewController(pokemonURL: selectedPokemon.url)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}


#Preview {
    return UINavigationController(rootViewController: PokemonListViewController())
}
