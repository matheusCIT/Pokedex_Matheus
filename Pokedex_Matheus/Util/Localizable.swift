//
//  Localizable.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import Foundation

struct Localizable {
    
    struct Details {
        struct Label {
            static let baseExpirence = "details.label.baseExperience".localized
            static let height = "details.label.height".localized
            static let id = "details.label.id".localized
            static let name = "details.label.name".localized
            static let weight = "details.label.weight".localized
            static let abilities = "details.label.abilities".localized
            static let moves = "details.label.moves".localized
            static let stat = "details.label.stat".localized
        }
        
        struct Format {
            static let baseExpirence = "details.format.baseExperience".localized
            static let height = "details.format.height".localized
            static let weight = "details.format.weight".localized
            
        }
        
        struct Abilities {
            struct Label {
                static let isHidden = "details.label.abilities.isHidden".localized
            }
        }
        
        struct Stats {
            struct Label {
                static let effort = "details.label.stats.effort".localized
                static let value = "details.label.stats.value".localized
            }
        }
    }
    
    struct Api {
        struct Error {
            static let url = "api.error.url"
            static let decoding = "api.error.decoding"
            static let responseCode = "api.error.response.code"
            static let unexpected = "api.error.unexpected"
        }
    }
    
}
