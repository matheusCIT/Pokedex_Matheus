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
    @Environment(\.imageCache) var cache: ImageCache
    @State var isLoading: Bool = true

    var body: some View {
        ScrollView {
            VStack{
                
                if !viewModel.sprites.isEmpty{
                    GeometryReader { geometry in
                        ImageCarouselView(numberOfImages: self.viewModel.sprites.count) {
                            ForEach(self.viewModel.sprites, id: \.self){ sprite in
                                AsyncImage(url: sprite, cache: self.cache, placeholder:ActivityIndicator(isAnimating: self.$isLoading, style: .medium) , configuration: { $0.resizable() })
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                            }
                            
//                            Image("image_carousel_1")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width, height: geometry.size.height)
//                                .clipped()
//                            Image("image_carousel_2")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width, height: geometry.size.height)
//                                .clipped()
//                            Image("image_carousel_3")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: geometry.size.width, height: geometry.size.height)
//                                .clipped()
                        }
                    }.frame(height: 300, alignment: .center)
                }
                
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
