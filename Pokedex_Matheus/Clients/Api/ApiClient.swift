//
//  ApiClient.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation
import Combine

public class ApiClient {
    private struct Constants {
        static let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
        static let webHookUrl = "https://webhook.site/0817b49f-9512-4050-986d-2c303865e29f"
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    fileprivate func callApi<T>(url: String, httpMethod: String, body: Data? = nil) -> AnyPublisher<T, ApiError> where T : Decodable {
        guard let url = URL(string: url) else {
            return Fail(error: ApiError.urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        if let body = body {
            request.httpBody = body
        }
        
        return URLSession.shared.dataTaskPublisher(for: request).receive(on: DispatchQueue.main).mapError { error in
            ApiError.unexpectedError(error.localizedDescription)
        }.flatMap{ result -> AnyPublisher<T, ApiError> in
            if let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode > 299 {
                return Fail<T, ApiError>(error: ApiError.responseError(httpResponse.statusCode)).eraseToAnyPublisher()
            }
            if !result.data.isEmpty {
                return Just(result.data).decode(type: T.self, decoder: JSONDecoder())
                    .mapError{ error in
                        ApiError.decodingError
                }.eraseToAnyPublisher()
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            
        }.eraseToAnyPublisher()
    }
}

extension ApiClient: ApiClientProtocol {
    func addFavoritePokemon(pokemon: FavoritePokemonResquest) -> AnyPublisher<String, ApiError> {
        let body = Data(try! JSONEncoder().encode(pokemon))
        return callApi(url: Constants.webHookUrl, httpMethod: "POST", body: body)
    }
    
    func getPokemonList(_ offSet: Int, _ limit: Int) -> AnyPublisher<ListResponse, ApiError> {
        let url = Constants.baseUrl.appending("?offset=\(offSet)&limit=\(limit)")
        return callApi(url: url, httpMethod: "GET")
    }
    
    func getPokemonDetails(_ id: Int) -> AnyPublisher<PokemonDetailsResponse, ApiError> {
        let url = Constants.baseUrl.appending(String(id))
        return callApi(url: url, httpMethod: "GET")
    }
}
