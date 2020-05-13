//
//  PokemonGateway.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

public class PokemonGateway {
    
    
    private let client: ApiClientProtocol
    
    init(client: ApiClientProtocol = ApiClient()) {
        self.client = client
    }
    
    enum GatewayError: Error {
        case gatewayError(String)
    }
    
    fileprivate func handleError(_ apiError: ApiError) -> Error {
        switch apiError {
        case .decodingError, .responseError,.urlError, .unexpectedError:
            return GatewayError.gatewayError("fodeu")
        }
    }
}

extension PokemonGateway: PokemonGatewayProtocol {
    
    func getPokemonList(_ offSet: Int, _ limit: Int) -> AnyPublisher<[PokemonListUntreatedModel], Error> {
        return client.getPokemonList(offSet, limit).mapError{(apiError) -> Error in
            return self.handleError(apiError)
        }.map{ response in
            var list:[PokemonListUntreatedModel] = []
            for item in response.results {
                list.append(PokemonListUntreatedModel(name: item.name, url: item.url))
            }
            return list
        }.eraseToAnyPublisher()
    }
    
    func getPokemonDetails(_ id: Int) -> AnyPublisher<PokemonModel, Error> {
        return client.getPokemonDetails(id).mapError{(apiError) -> Error in
            return self.handleError(apiError)
        }.map{ response in
            return PokemonModel(response: response)
        }.eraseToAnyPublisher()
    }
    
    func addFavoritePokemon(pokemon: PokemonModel) -> AnyPublisher<String, Error> {
        let request = FavoritePokemonResquest.init(id: pokemon.id, name: pokemon.name)
        return client.addFavoritePokemon(pokemon: request).mapError{(apiError) -> Error in
            return self.handleError(apiError)
        }.eraseToAnyPublisher()
    }
    
}
