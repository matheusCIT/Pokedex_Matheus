//
//  PokemonModel.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

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
