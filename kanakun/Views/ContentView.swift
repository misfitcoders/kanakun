//
//  ContentView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 12/07/2020.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        ZStack {
            if router.currentPage == .root {
                FrontView()
            }
            else if router.currentPage == .game { GameView()
                .transition(.scale)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewRouter())
    }
}
