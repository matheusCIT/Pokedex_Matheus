//
//  PokemonListViewModel.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

final class PokemonListViewModel: ObservableObject {
    @Published var pokemons =  [PokemonListModel]()
    var count = 0
    let limit = 50
    
    var gateway: PokemonGatewayProtocol
    
    init(dataManager: PokemonGatewayProtocol = PokemonGateway.shared) {
        self.gateway = dataManager
        fetchPokemons()
    }
    var cancellableSet: Set<AnyCancellable> = []
}

//MARK: - PokemonListViewModelProtocol
extension PokemonListViewModel: PokemonListViewModelProtocol {
    func fetchPokemons(current: PokemonListModel? = nil) {
        
        if !shouldLoadMore(current: current) {
            return
        }
        
        let response:AnyPublisher<ListResponse, Error> = gateway.fetchData(endpoint: "https://pokeapi.co/api/v2/pokemon/?offset=\(count)&limit=\(count+limit)")
            
        response.sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                    guard let results = result.results else {
                        return
                    }
                    for pokemon in results {
                        self.pokemons.append(PokemonListModel.init(id: self.getPokemonId(from: pokemon.url), name: pokemon.name, image: nil, url: pokemon.url, isFavorite: true))
                    }
                    self.count = self.pokemons.count
            }).store(in: &cancellableSet)
        
    }
    
    func toggleIsFavorite(for pokemon: PokemonListModel) {
        gateway.toggleIsFavorite(for: pokemon)
    }
    
    private func shouldLoadMore(current: PokemonListModel?) -> Bool{
        guard let current = current else {
            return true
        }
        guard let last = pokemons.last else {
            return true
        }
        
        if current.id == last.id {
            return true
        }
        
        return false
    }
    
    private func getPokemonId(from url: String) -> Int{
        do{
            let regex = try NSRegularExpression(pattern: #"((?<=\/)[0-9]\d*(?=\/))"#)
            let results = regex.firstMatch(in: url,options: [], range: NSRange(url.startIndex..., in: url))
            let index = results.map{ (result) -> String in
                if let range = Range(result.range, in: url) {
                    return String(url[range])
                } else {
                    return "0"
                }
            }
            guard let validIndex = index else {
                return 0
            }
            return Int(validIndex) ?? 0
        } catch {
            return 0
        }
    }
}

