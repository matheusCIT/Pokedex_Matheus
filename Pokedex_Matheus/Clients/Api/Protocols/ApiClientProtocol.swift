//
//  ApiClientProtocol.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol ApiClientProtocol {
    func getPokemonList(_ offSet: Int, _ limit: Int) -> AnyPublisher<ListResponse, ApiError>
    func getPokemonDetails(_ id: Int) -> AnyPublisher<PokemonDetailsResponse, ApiError>
    func addFavoritePokemon(pokemon: FavoritePokemonResquest) -> AnyPublisher<String, ApiError>
}
