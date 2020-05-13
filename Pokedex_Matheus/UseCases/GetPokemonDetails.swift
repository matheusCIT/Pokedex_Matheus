//
//  GetPokemonDetails.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

class GetPokemonDetails {
    private let gateway: PokemonGatewayProtocol
    static let shared: GetPokemonDetailsProtocol = GetPokemonDetails()
    
    init(gateway: PokemonGatewayProtocol = PokemonGateway()) {
        self.gateway = gateway
    }
}

extension GetPokemonDetails: GetPokemonDetailsProtocol {
    func execute(_ id: Int) -> AnyPublisher<PokemonModel, Error> {
        return gateway.getPokemonDetails(id)
    }
    
    
}
