//
//  ImageCarouselView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 11/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI
import Combine

struct SpritesView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content

    @State private var currentIndex: Int = 0
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .gesture(DragGesture()
                        .onEnded({ (value) in
                        if value.translation.width < -30 {
                            self.currentIndex = (self.currentIndex + 1) % (self.numberOfImages == 0 ? 1 : self.numberOfImages)
                        } else if value.translation.width > 30 {
                            self.currentIndex = self.currentIndex == 0 ? self.numberOfImages - 1 : self.currentIndex - 1
                        }
                        })).animation(.spring())
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                
                HStack(spacing: 3) {
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        Circle().frame(width: index == self.currentIndex ? 10 : 8, height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.blue : .white)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        
        // 8
        GeometryReader { geometry in
            SpritesView(numberOfImages: 3) {
                Image("image_carousel_1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("image_carousel_2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("image_carousel_3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
        }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    }
}
