//
//  AbilitiesView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct AbilitiesView: View {
    private let abilities: [AbilityModel]
    
    init(abilities: [AbilityModel]) {
        self.abilities = abilities
    }
    
    var body: some View {
        VStack {
            ForEach(abilities, id: \.name) { ability in
                Group{
                    HStack{
                        Text(ability.name).font(.headline)
                        Spacer()
                        Text(Localizable.Details.Abilities.Label.isHidden).font(.caption)
                        ability.isHidden ? Image(systemName: "checkmark").imageScale(.large).foregroundColor(.green) : Image(systemName: "multiply").imageScale(.large).foregroundColor(.red)
                    }.padding([.leading, .trailing])
                    Divider()
                }
            }
        }
    }
}

struct AbilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AbilitiesView(abilities: [AbilityModel(name: "Teste", isHidden: true),
        AbilityModel(name: "Teste2", isHidden: false)])
    }
}
