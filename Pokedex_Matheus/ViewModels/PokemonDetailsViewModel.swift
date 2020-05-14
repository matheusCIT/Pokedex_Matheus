//
//  PokemonDetailsViewModel.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 09/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

final class PokemonDetailsViewModel: ObservableObject {
    @Published var pokemon: PokemonModel?
    
    let useCase: GetPokemonDetailsProtocol
    let recivedId: Int
    let favoriteUseCase: AddFavoritePokemonProtocol
    
    init(recivedId: Int, useCase: GetPokemonDetailsProtocol = GetPokemonDetails.shared, favoriteUseCase: AddFavoritePokemonProtocol = AddFavoritePokemon.shared) {
        self.recivedId = recivedId
        self.useCase = useCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    var cancellableSet: Set<AnyCancellable> = []
    
    var sprites: [String] {
        return pokemon?.sprites ?? []
    }
    var baseExperience: ContentModel {
        return ContentModel(label: Localizable.Details.Label.baseExpirence, value: String(format: Localizable.Details.Format.baseExpirence, (pokemon?.baseExperience ?? 0)))
    }
    
    var height: ContentModel {
        return ContentModel(label: Localizable.Details.Label.height, value: String(format: Localizable.Details.Format.height, (pokemon?.height ?? 0)))
    }
    
    var id: ContentModel {
        return ContentModel(label: Localizable.Details.Label.id, value: String(pokemon?.id ?? 0))
    }
    
    var name: ContentModel {
        return ContentModel(label: Localizable.Details.Label.name, value: pokemon?.name ?? "")
    }
    
    var weight: ContentModel {
        return ContentModel(label: Localizable.Details.Label.weight, value: String(format: Localizable.Details.Format.weight, (pokemon?.weight ?? 0)))
    }
    
    var moves: MovesView {
        return MovesView(moves: pokemon?.moves ?? [])
    }
    
    var abilities: AbilitiesView {
        return AbilitiesView(abilities: pokemon?.abilities ?? [])
    }
    
    var stats: StatsView {
        return StatsView(stats: pokemon?.stats ?? [])
    }
    
    
}

extension PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    
    func fetchPokemonDetails() {
        let response:AnyPublisher<PokemonModel, Error> = useCase.execute(recivedId)
        
        response.sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            self.pokemon = result
        }).store(in: &cancellableSet)
    }
    
    func addFavorite() {
        guard let pokemon = pokemon else {
            return
        }
        favoriteUseCase.execute(pokemon: pokemon)
    }
}
