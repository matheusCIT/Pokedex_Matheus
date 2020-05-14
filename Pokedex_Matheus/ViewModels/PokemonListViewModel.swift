//
//  PokemonListViewModel.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

final class PokemonListViewModel: ObservableObject {
    @Published var pokemons =  [PokemonListModel]()
    var count = 0
    let limit = 50
    
    var useCase: GetPokemonListProtocol
    
    init(useCase: GetPokemonListProtocol = GetPokemonList.shared) {
        self.useCase = useCase
        fetchPokemons()
    }
    var cancellableSet: Set<AnyCancellable> = []
}

extension PokemonListViewModel: PokemonListViewModelProtocol {
    func fetchPokemons(current: PokemonListModel? = nil) {
        
        if !shouldLoadMore(current: current) {
            return
        }
        
        let response:AnyPublisher<[PokemonListModel], Error> = useCase.execute(count, count+limit)
            
        response.sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                    self.pokemons.append(contentsOf: result)
                    self.count = self.pokemons.count
            }).store(in: &cancellableSet)
        
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

