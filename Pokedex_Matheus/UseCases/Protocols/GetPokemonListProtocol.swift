//
//  File.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

protocol GetPokemonListProtocol {
    func execute(_ offset: Int, _ limit: Int) -> AnyPublisher<[PokemonListModel], Error>
}
