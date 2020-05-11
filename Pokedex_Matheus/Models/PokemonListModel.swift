//
//  PokemonListModel.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

struct PokemonListModel: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String?
    let url: String
    var isFavorite = false
}
