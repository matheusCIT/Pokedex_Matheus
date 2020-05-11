//
//  AsyncImage.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 11/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

public struct AsyncImage<Placeholder: View>: View {
    
    // MARK: Properties
    
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let configuration: (Image) -> Image
    
    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
            } else {
                placeholder
            }
        }
    }
    
    public init(url: String, cache: ImageCache? = nil, placeholder: Placeholder? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
        loader = ImageLoader(url: url, cache: cache)
        self.placeholder = placeholder
        self.configuration = configuration
    }
    
    // MARK: View
    
    public var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
}
