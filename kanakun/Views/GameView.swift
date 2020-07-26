//
//  GameView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 13/07/2020.
//

import SwiftUI
import Combine
import jisho_swift

struct GameView: View {
    
    @EnvironmentObject var gameContent: GameContentController
    @EnvironmentObject var router: ViewRouter
    @ObservedObject var gamePlay = GamePlayController.game
    @State var showingDetail = false
    
    var failureGradient: LinearGradient {
        return self.gamePlay.failed > 0
            ? LinearGradient.RedGradient
            : LinearGradient.GreenGradient
    }
    
    var failureIcon: Image {
        Image(systemName: "\(gamePlay.failed).circle.fill")
    }
    
    func newGame() {
        gamePlay.startGameWith(content: gameContent.next(
            failed: gamePlay.content.isEmpty
                ? nil
                : gamePlay.failed
        ))
    }
    
    var bottomBar: some View {
        HStack {
            Button( action: {
                self.router.currentPage = .root
                }
            ) {
                Image(systemName: "multiply.circle.fill")
                    .font(.title)
                    .foregroundColor(.Madison)
                    .padding(.leading, 20)
            }
            Spacer()
            Button( action: {
                if self.gameContent.content != nil {
                    self.showingDetail.toggle()
                }
            }) {
                Image(systemName: "book.fill")
                    .font(.title)
                    .foregroundColor(.Madison)
                    //.padding(30)
            }.sheet(isPresented: $showingDetail) {
                GameDetails(
                    slug: self.gameContent.content?.slug ?? "...",
                    reading: self.gameContent.content?.content ?? "...",
                    senses: self.gameContent.content?.senses ?? "...",
                    isPresented: self.$showingDetail
                ).background(Color.gray.opacity(0.5))
            }
            Spacer()
            
            failureGradient
            .mask(failureIcon.resizable().scaledToFit())
            .frame(width: 32, height: 32)
            .font(.system(size: 32, weight: .thin))
            .shadow(color: .white, radius: 2, x: -3, y: -3)
            .shadow(color: .Manatee, radius: 2, x: 3, y: 3)
                        
            Spacer()
            Button( action: {
                self.gamePlay.toggleMode()
            }) {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .font(.title)
                    .foregroundColor(.Madison)
                    //.padding(30)
            }
            Spacer()
            Button( action: {
                self.newGame()
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title)
                    .foregroundColor(.Madison)
                    .padding(.trailing, 20)
            }
        }
    }
    
    @ViewBuilder
    var body: some View {
        if gamePlay.content.isEmpty || gamePlay.success {
            VStack { Text("Loading content") }
                .onAppear { self.newGame() }
        }
        else {
            
            GeometryReader { geometry in
                ZStack{
                    Color.Glitter
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Spacer()
                        GameIndicator(
                            content: self.gamePlay
                                .content
                                .enumerated()
                                .map {
                                    EnumeratedToken(
                                        index: $0.offset,
                                        token: $0.element,
                                        mode: self.gamePlay.mode
                                    )
                            },
                            cursor: self.gamePlay.cursor,
                            failure: self.gamePlay.failed
                        )
                        Spacer()
                        GamePad(
                            padItems: self.gamePlay
                                .padItems
                                .enumerated()
                                .map {
                                    EnumeratedToken(
                                        index: $0.offset,
                                        token: $0.element,
                                        mode: self.gamePlay.mode
                                    )
                            },
                            checkAnswer: self.gamePlay.checkAnswer)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.width,
                                alignment: .center)
                        
                        //                        TimerBar(value: $progressValue)
                        //                            .frame(height: 5)
                        //                            .padding(.horizontal, 20)
                        
                        self.bottomBar
                            .padding(.vertical, 40)
                        
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            
        }
    }
}

struct TimerBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: geometry.size.width ,
                        height: geometry.size.height
                    )
                    .opacity(0.3)
                    .foregroundColor(Color.Astronaut)
                Rectangle()
                    .frame(
                        width: min(
                                CGFloat(self.value)*geometry.size.width,
                                geometry.size.width
                        ),
                        height: geometry.size.height)
                    .foregroundColor(Color.FrenchRose)
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().onAppear {
            let game = GamePlayController.game
            game.content = "ていすかんなにまく".tokenizedAll
            game.resetGame()
        }
    }
}
