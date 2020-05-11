//
//  PokemonDetailsViewModelProtocol.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 09/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol PokemonDetailsViewModelProtocol {
    var pokemon: PokemonModel? { get }
    func fetchPokemonDetails()
}
