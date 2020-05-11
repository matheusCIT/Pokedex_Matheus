////
////  SpritesView.swift
////  Pokedex_Matheus
////
////  Created by Matheus Cavalcante Teixeira on 11/05/20.
////  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
////

import SwiftUI

struct SpritesView: View {
    private struct Constants {
        static let imageSize: CGFloat = 80
    }
        
    // MARK: Properties
    
    @Environment(\.imageCache) var cache: ImageCache
    @State var isLoading: Bool = true

    private let url: [String]
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameter viewModel: A InfoViewModel instance
    init(url: [String]) {
        self.url = url
    }
    
    // MARK: View
    
    var body: some View {
//        VStack(alignment: .leading){
            ScrollView{
                HStack{
                    ForEach(url, id: \.self) { sprite in
                            AsyncImage(url: sprite, cache: self.cache, placeholder: ActivityIndicator(isAnimating: self.$isLoading, style: .medium), configuration: { $0.resizable() }).aspectRatio(contentMode: .fill).frame(width: 100, height: 100, alignment: .center)
                            
                    }
                }
            }
//        }
    }
}

    struct SpritesView_Previews: PreviewProvider {
        static var previews: some View {
//            let viewModel = InfoViewModel(name: "front_default", value: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
            return SpritesView(url: ["https://raw.githubuserco…rites/pokemon/back/1.png", "https://raw.githubuserco…pokemon/back/shiny/1.png","https://raw.githubuserco…er/sprites/pokemon/1.png","https://raw.githubuserco…ites/pokemon/shiny/1.png","https://raw.githubuserco…ites/pokemon/shiny/2.png","https://raw.githubuserco…ites/pokemon/shiny/3.png"])
        }
    }
