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
    
    var dataManager: PokemonGatewayProtocol
    
    init(dataManager: PokemonGatewayProtocol = PokemonGateway.shared) {
        self.dataManager = dataManager
        
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
        
        let response:AnyPublisher<ListResponse, Error> = dataManager.fetchPokemonList(endpoint: "https://pokeapi.co/api/v2/pokemon/?offset=\(count)&limit=\(count+limit)")
            
        response.sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                    let results = result.results!
                    var index = self.count
                    for r in results {
                        index += 1
                        self.pokemons.append(PokemonListModel.init(id: index, name: r.name, image: nil, isFavorite: false))
                    }
                    self.count = self.pokemons.count
            }).store(in: &cancellableSet)
        
    }
    
    func toggleIsFavorite(for pokemon: PokemonListModel) {
        dataManager.toggleIsFavorite(for: pokemon)
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
}
