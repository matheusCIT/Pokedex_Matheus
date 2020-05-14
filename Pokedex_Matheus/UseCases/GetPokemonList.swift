//
//  File.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

class GetPokemonList {
    
    private let gateway: PokemonGatewayProtocol
    static let shared: GetPokemonListProtocol = GetPokemonList()
        
    init(gateway:PokemonGatewayProtocol = PokemonGateway()) {
        self.gateway = gateway
    }
    
    private func getPokemonId(from url: String) -> Int{
        do{
            let regex = try NSRegularExpression(pattern: #"((?<=\/)[0-9]\d*(?=\/))"#)
            let results = regex.firstMatch(in: url,options: [], range: NSRange(url.startIndex..., in: url))
            let index = results.map{ (result) -> String in
                if let range = Range(result.range, in: url) {
                    return String(url[range])
                } else {
                    return "0"
                }
            }
            guard let validIndex = index else {
                return 0
            }
            return Int(validIndex) ?? 0
        } catch {
            return 0
        }
    }
    
    private func getFrontSprite(_ id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
}

extension GetPokemonList: GetPokemonListProtocol {
    func execute(_ offset: Int, _ limit: Int) -> AnyPublisher<[PokemonListModel], Error> {
        gateway.getPokemonList(offset, limit).map{response in
            var result:[PokemonListModel] = []
            var id: Int
            for item in response {
                id = self.getPokemonId(from: item.url)
                result.append(PokemonListModel(id: id, name: item.name, image: self.getFrontSprite(id)))
            }
            return result
        }.eraseToAnyPublisher()
    }
    
    
}
