//
//  MovesView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct MovesView: View {
    var moves: [String]
    
init(moves: [String]) {
    self.moves = moves
    }
    var body: some View {
        VStack{
            ForEach(self.moves, id: \.self) { move in
                HStack{
                    Text(move).padding().font(.headline)
                    Spacer()
                }
            }
        }
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView(moves: ["teste", "teste 2"])
    }
}
