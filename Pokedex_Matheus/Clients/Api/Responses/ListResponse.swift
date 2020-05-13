//
//  ListResponse.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

struct ListResponse: Codable {
    let results: [PokemonList]
}

struct PokemonList: Codable {
    let name: String
    let url: String
}
