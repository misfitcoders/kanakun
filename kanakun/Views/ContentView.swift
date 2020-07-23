//
//  ContentView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 12/07/2020.
//

import SwiftUI
import Combine
import jisho_swift
import wanakana_swift

struct ContentView: View {
    
    var gameContent = GameContentController()
    
    var body: some View {
        ZStack {
            NavigationView {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 300)
                Spacer()
                NavigationLink(
                destination:
                    GameView()
                    .navigationBarHidden(true),
                label: {
                    ZStack{
                        Capsule()
                            .fill(Color.Astronaut)
                            .frame(width: 300, height: 50, alignment: .center)
                        Text("Words")
                            .foregroundColor(.white)
                    }
                }
            )
            .navigationBarHidden(true)
                NavigationLink(
                destination:
                    GameView()
                    .navigationBarHidden(true),
                label: {
                    ZStack{
                        Capsule()
                            .fill(Color.Astronaut)
                            .frame(width: 300, height: 50, alignment: .center)
                        Text("Proverbs")
                            .foregroundColor(.white)
                    }
                }
            )
                Spacer()
                NavigationLink(
                destination:
                    GameView()
                    .navigationBarHidden(true),
                label: {
                    Image(systemName: "gearshape.fill")
                        .font(.largeTitle)
                }
            )
                Spacer()
            }
        }
            
        }
        .environmentObject(gameContent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
