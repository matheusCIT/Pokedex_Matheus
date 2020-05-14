//
//  ApiClientMock.swift
//  Pokedex_MatheusTests
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

public class ApiClientMock {
    
    var listResponse: ListResponse?
    var pokemonDetailsResponse: PokemonDetailsResponse?
    var favoriteResponse: String?
    var error: ApiError?
}

extension ApiClientMock: ApiClientProtocol {
    func getPokemonList(_ offSet: Int, _ limit: Int) -> AnyPublisher<ListResponse, ApiError> {
        guard let listResponse = listResponse else {
            return Fail(error: error!).eraseToAnyPublisher()
        }
        return Just(listResponse).mapError({ (error) -> ApiError in
            ApiError.unexpectedError("")
        }).eraseToAnyPublisher()
    }
    
    func getPokemonDetails(_ id: Int) -> AnyPublisher<PokemonDetailsResponse, ApiError> {
        guard let pokemonDetailsResponse = pokemonDetailsResponse else {
            return Fail(error: error!).eraseToAnyPublisher()
        }
        return Just(pokemonDetailsResponse).mapError({ (error) -> ApiError in
            ApiError.unexpectedError("")
        }).eraseToAnyPublisher()
    }
    
    func addFavoritePokemon(pokemon: FavoritePokemonResquest) -> AnyPublisher<String, ApiError>{
        guard let favoriteResponse = favoriteResponse else {
            return Fail(error: error!).eraseToAnyPublisher()
        }
        return Just(favoriteResponse).mapError({ (error) -> ApiError in
            ApiError.unexpectedError("")
        }).eraseToAnyPublisher()
    }
}
