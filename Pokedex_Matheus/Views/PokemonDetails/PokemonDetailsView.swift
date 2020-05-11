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
    private struct Constants {
        static let imageSize: CGFloat = 80
    }
    @ObservedObject var viewModel: PokemonDetailsViewModel
    @Environment(\.imageCache) var cache: ImageCache
    @State var isLoading: Bool = true

    var body: some View {
        ScrollView {
            VStack{
                AsyncImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/5.png", cache: cache, placeholder: ActivityIndicator(isAnimating: $isLoading, style: .medium), configuration: { $0.resizable() })
                .frame(width: Constants.imageSize, height: Constants.imageSize)
//                AsyncImage(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png", cache: cache, placeholder: ActivityIndicator(isAnimating: $isLoading, style: .medium), configuration: { $0.resizable() })
//                .frame(width: 80, height: 80)
                
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
        PokemonDetailsView(viewModel: PokemonDetailsViewModel(detailsUrl: "https://pokeapi.co/api/v2/pokemon/4/"))
    }
}
