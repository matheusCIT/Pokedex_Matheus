//
//  File.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

class PokemonGateway {
    
    static let shared: PokemonGatewayProtocol = PokemonGateway()
    
    private var pokemons = [PokemonListModel]()
    
}

// MARK: - DataManagerProtocol
extension PokemonGateway: PokemonGatewayProtocol {
    func fetchData<T:Decodable>(endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: RequestError.invalidUrl).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> T in
                return try decoder.decode(T.self, from: result.data)
            }
            .eraseToAnyPublisher()
        
    }
    
    func toggleIsFavorite(for pokemon: PokemonListModel) {
        if let index = pokemons.firstIndex(where: { (model) -> Bool in model.id == pokemon.id }) {
            pokemons[index].isFavorite.toggle()
        }
    }
}

struct ListResponse: Codable {
    let count: Int?
    let previous: String?
    let results: [PokemonList]?
}

struct PokemonList: Codable {
    let name: String
    let url: String
}

public enum RequestError: Error {
    case invalidUrl
    case invalidMethod
    case invalidResponse
    case invalidData
    case noInternetConnection
    case serverError(code: Int, data: Data?)
    case unhandled(error: Error)
}
