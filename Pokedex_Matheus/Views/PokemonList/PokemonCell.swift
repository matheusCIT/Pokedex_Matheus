//
//  PokemonCell.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct PokemonCell: View {
    var pokemon: PokemonListModel
    
    var body: some View {
        HStack{
            Text(String(pokemon.id))
            Text(pokemon.name)
            Spacer()
        }
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: PokemonListModel(id:1 ,name: "Bulbasaur"))
    }
}
