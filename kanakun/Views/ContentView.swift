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
    @State var showingFeedback = false
    
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
                                Text("Practice")
                                    .foregroundColor(.white)
                            }
                        }
                    )
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    Spacer()
                    Button( action: {
                        self.showingFeedback.toggle()
                    }) {
                        Image(systemName: "questionmark.diamond.fill")
                            .font(.title)
                            .foregroundColor(.Astronaut)
                    }.sheet(isPresented: $showingFeedback) {
                       FeedbackView()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
