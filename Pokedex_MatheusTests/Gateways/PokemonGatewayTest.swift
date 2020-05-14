//
//  PokemonGatewayTest.swift
//  Pokedex_MatheusTests
//
//  Created by Matheus Cavalcante Teixeira on 13/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

import XCTest
@testable import Pokedex_Matheus

class PokemonGatewayTest: XCTestCase {
    
    var cancellableSet: Set<AnyCancellable> = []
    var testUtils = TestUtils()
    
    func testGetPokemonDetailsSuccess() throws {
        let clientMock = ApiClientMock()
        guard let response: PokemonDetailsResponse = testUtils.getJson(jsonName: "PokemonDetails") else {
            return XCTFail("invalid Json")
        }
        clientMock.pokemonDetailsResponse = response
        
        let gateway = PokemonGateway(client: clientMock)
        let gatewayReturn = gateway.getPokemonDetails(1)
        gatewayReturn.sink(receiveCompletion: { _ in
        }, receiveValue: { result in
            
            assert(result.id == response.id)
            assert(result.name == response.name)
            assert(result.baseExperience == response.baseExperience)
            assert(result.height == response.height)
            assert(result.id == response.id)
            assert(result.name == response.name)
            assert(result.weight == response.weight)
            assert(result.abilities.count == response.abilities.count)
            assert(result.moves.count == response.moves.count)
            assert(result.stats.count == response.stats.count)
            
            
            
            
        }).store(in: &cancellableSet)
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
