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
    
    var gateway: PokemonGatewayProtocol
    var detailsUrl: String
    
    init(detailsUrl: String, gateway: PokemonGatewayProtocol = PokemonGateway.shared) {
        self.detailsUrl = detailsUrl
        self.gateway = gateway
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
        
        let response:AnyPublisher<PokemonDetailsResponse, Error> = gateway.fetchData(endpoint: detailsUrl)
            
        response.sink(receiveCompletion: { _ in },
                  receiveValue: { PokemonDetailsResponse in
                    self.pokemon = PokemonModel(response: PokemonDetailsResponse)
            }).store(in: &cancellableSet)
    }
    
    
}

struct PokemonModel {
    let baseExperience: Int
    let height: Int
    let id: Int
    let name: String
    let weight: Int
    let abilities: [AbilityModel]
    let moves: [String]
    var sprites: [String] = []
    let stats: [StatModel]
    
    init(response: PokemonDetailsResponse) {
        abilities = response.abilities.map { (abilityResponse) -> AbilityModel in
            return AbilityModel(name: abilityResponse.ability.name, isHidden: abilityResponse.isHidden)}
        
        moves = response.moves.map({ (moveResponse) -> String in
            return moveResponse.move.name
        })
        
        sprites.append(contentsOf: response.sprites.compactMap { (sprite) -> String? in
            return sprite.value
        })
        
        stats = response.stats.map({ (statsResponse) -> StatModel in
            return StatModel(baseStat: String(statsResponse.baseStat), effort: String(statsResponse.effort), name: statsResponse.stat.name)
        })
 
        baseExperience = response.baseExperience
        height = response.height
        id = response.id
        name = response.name
        weight = response.weight
    }
}

struct AbilityModel {
    let name: String
    let isHidden: Bool
}

struct StatModel {
    let baseStat: String
    let effort: String
    let name: String
}
