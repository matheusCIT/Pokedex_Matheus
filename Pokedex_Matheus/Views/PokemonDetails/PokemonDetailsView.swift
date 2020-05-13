//
//  PokemonDetailsView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 09/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI
import Combine

struct PokemonDetailsView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel
    

    var body: some View {
        ScrollView {
            VStack{
                
                if !viewModel.sprites.isEmpty{
                    GeometryReader { geometry in
                        SpritesView(numberOfImages: self.viewModel.sprites.count) {
                            ForEach(self.viewModel.sprites, id: \.self){ sprite in
                                ImageView(sprite: sprite).frame(width: geometry.size.width, height: geometry.size.height)
                            }
                        }
                    }.frame(height: 300, alignment: .center)
                }
                
                Button(action: {
                    self.viewModel.addFavorite()}
                ){ Text("add favorite")}
                
                if !viewModel.id.value.isEmpty {
                    ContentView(model: viewModel.id)
                }
                if !viewModel.name.value.isEmpty {
                    ContentView(model: viewModel.name)
                }
                if !viewModel.baseExperience.value.isEmpty {
                    ContentView(model: viewModel.baseExperience)
                }
                if !viewModel.height.value.isEmpty {
                    ContentView(model: viewModel.height)
                }
                if !viewModel.weight.value.isEmpty {
                    ContentView(model: viewModel.weight)
                }
                
                AccordionView(title: Localizable.Details.Label.abilities.localized, internalView: AnyView(viewModel.abilities))
                AccordionView(title: Localizable.Details.Label.moves.localized, internalView: AnyView(viewModel.moves))
                AccordionView(title: Localizable.Details.Label.stat.localized, internalView: AnyView(viewModel.stats))
                
            }.onAppear{
                self.viewModel.fetchPokemonDetails()
            }
        }
    }
    
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(viewModel: PokemonDetailsViewModel(recivedId: 4))
    }
}
