//
//  File.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol PokemonGatewayProtocol {
    func fetchPokemonList<T:Decodable>(endpoint: String) -> AnyPublisher<T, Error>
    func toggleIsFavorite(for pokemon: PokemonListModel)
}
