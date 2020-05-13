//
//  ApiError.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 12/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case urlError
    case responseError(Int)
    case decodingError
    case unexpectedError(String)
    
    var localizedDescription: String {
        switch self {
            case .urlError:
                return Localizable.Api.Error.url.localized
            case .decodingError:
                return Localizable.Api.Error.decoding.localized
            case .responseError(let status):
                return String(format: Localizable.Api.Error.responseCode.localized, status)
            case .unexpectedError(let description):
                return Localizable.Api.Error.unexpected.localized + description
        }
    }
}
