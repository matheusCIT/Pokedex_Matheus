//
//  PokemonListViewModelProtocol.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol PokemonListViewModelProtocol {
    
    var pokemons: [PokemonListModel] { get }
    
    func fetchPokemons(current: PokemonListModel?)
}
