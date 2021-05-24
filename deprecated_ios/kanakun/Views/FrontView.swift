//
//  FrontView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 26/07/2020.
//  Copyright © 2020 Misfitcoders. All rights reserved.
//

import SwiftUI

struct FrontView: View {
    @State var showingFeedback = false
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        ZStack {
            Color.Glitter
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 300, height: 300)
                Spacer()
                Button(action: { self.router.currentPage = .game })
                {
                    ZStack{
                        Capsule()
                            .fill(Color.Madison)
                            .frame(
                                width: 300,
                                height: 50,
                                alignment: .center
                            )
                        Text("Practice")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                Button( action: {
                    self.showingFeedback.toggle()
                }) {
                    Image(systemName: "questionmark.diamond.fill")
                        .font(.title)
                        .foregroundColor(.Madison)
                }.sheet(isPresented: $showingFeedback) {
                    FeedbackView()
                }
                Spacer()
            }
        }
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView()
    }
}
