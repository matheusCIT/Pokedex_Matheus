//
//  AddFavoritePokemon.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

class AddFavoritePokemon {
    public static let shared = AddFavoritePokemon()
    private let gateway:PokemonGatewayProtocol = PokemonGateway()
    private var cancellableSet: Set<AnyCancellable> = []

}

extension AddFavoritePokemon: AddFavoritePokemonProtocol {
    func execute(pokemon: PokemonModel) {
        gateway.addFavoritePokemon(pokemon: pokemon).sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            print(result)
        }).store(in: &cancellableSet)
    }
}
