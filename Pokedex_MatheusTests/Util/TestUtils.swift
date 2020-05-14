//
//  TestUtils.swift
//  Pokedex_MatheusTests
//
//  Created by Matheus Cavalcante Teixeira on 14/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

class TestUtils {
    
    func getJson<T>(jsonName: String) -> T? where T: Decodable {
        guard let path = Bundle(for: type(of: self)).path(forResource: jsonName, ofType: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
