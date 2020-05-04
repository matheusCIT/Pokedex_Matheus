//
//  PokemonList.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 03/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemons) { pokemon in
                PokemonCell(pokemon: pokemon).onAppear {
                    self.viewModel.fetchPokemons(current: pokemon)
                }
            }
        .navigationBarTitle(Text("Pokemons"))
        }
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
