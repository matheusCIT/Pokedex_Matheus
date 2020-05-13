//
//  GetPokemonDetailsProtocol.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol GetPokemonDetailsProtocol {
    func execute(_ id: Int) -> AnyPublisher<PokemonModel, Error>
}
