//
//  Teste.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 11/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @Environment(\.imageCache) var cache: ImageCache
    @State var isLoading: Bool = true
    
    var sprite: String
    
    init(sprite: String) {
        self.sprite = sprite
    }
    var body: some View {
        AsyncImage(url: sprite, cache: self.cache, placeholder:ActivityIndicator(isAnimating: self.$isLoading, style: .medium) , configuration: { $0.resizable() })
        .scaledToFill()
    }
}

struct Teste_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(sprite: "hue")
    }
}
