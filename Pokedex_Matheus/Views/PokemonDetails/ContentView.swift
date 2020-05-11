//
//  ContentView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let model: ContentModel
    
    init(model: ContentModel) {
        self.model = model
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(model.label)
                    .font(.headline)
                Spacer()
                Text(model.value)
                    .font(.subheadline)
            }.padding([.leading, .trailing])
            Divider()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ContentModel(label: "asdasd", value: "adsasd"))
    }
}
