//
//  AccordionView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct AccordionView: View {
    
    var title: String
    var internalView: AnyView
    
    @State private var showDetail = false
    
    init(title: String, internalView: AnyView) {
        self.title = title
        self.internalView = internalView
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                Spacer()
                Button(action: {
                    withAnimation(){
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .padding().transition(.scale)
                }
            }
            
            if showDetail {
                internalView.transition(.opacity)
            }
        }
    }
}

struct AccordionView_Previews: PreviewProvider {
    static var previews: some View {
        AccordionView(title: "teste", internalView: AnyView(ContentView(model: ContentModel(label: "teste", value: "teste"))))
    }
}
