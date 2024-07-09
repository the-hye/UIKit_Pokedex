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
        // Do any additional setup after loading the view.
//        view.addSubview(tableView)
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
    
    private func fetchPokemonList() {
        PokemonAPI.fetchPokemonList { [weak self] pokemonList in
            guard let self = self, let pokemonList = pokemonList else { return }
            self.pokemonList = pokemonList.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
    
}


#Preview {
    return UINavigationController(rootViewController: PokemonListViewController())
}
