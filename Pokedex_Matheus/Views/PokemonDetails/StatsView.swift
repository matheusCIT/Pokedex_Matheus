//
//  StatsView.swift
//  Pokedex_Matheus
//
//  Created by Matheus Cavalcante Teixeira on 10/05/20.
//  Copyright © 2020 Matheus Cavalcante Teixeira. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    var stats: [StatModel]
    
    init(stats: [StatModel]) {
        self.stats = stats
    }
    
    var body: some View {
        VStack{
            ForEach(stats, id: \.name) { stat in
                Group {
                    HStack{
                        Text(stat.name).font(.headline)
                        Spacer()
                        VStack(alignment: .leading){
                            HStack{
                                Text(Localizable.Details.Stats.Label.value).font(.caption)
                                Text(stat.baseStat).font(.caption)
                            }
                            HStack{
                                Text(Localizable.Details.Stats.Label.effort).font(.caption)
                                Text(String(stat.effort)).font(.caption)
                            }
                        }
                    }.padding([.leading, .trailing])
                    Divider()
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(stats: [StatModel(baseStat: "70", effort: "2", name: "speed"),
        StatModel(baseStat: "70", effort: "2", name: "hue")])
    }
}
