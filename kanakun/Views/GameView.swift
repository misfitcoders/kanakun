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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var gameContent: GameContentController
    @ObservedObject var gamePlay = GamePlayController.game
    @State var showingDetail = false
    
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
                    self.presentationMode.wrappedValue.dismiss()
                }
            ) {
                Image(systemName: "multiply.circle.fill") //"smallcircle.fill.circle")
                    .font(.title)
                    //.aspectRatio(contentMode: .fit)
                    .foregroundColor(.Astronaut)
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
                    .foregroundColor(.Astronaut)
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
            Image(systemName: "\(gamePlay.failed).circle.fill")
                            .font(Font.system(.largeTitle).bold())
                            .foregroundColor(.PersianPink)
                        
            Spacer()
            Button( action: {
                self.gamePlay.toggleMode()
            }) {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .font(.title)
                    .foregroundColor(.Astronaut)
                    //.padding(30)
            }
            Spacer()
            Button( action: {
                self.newGame()
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title)
                    .foregroundColor(.Astronaut)
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
           NavigationView {
                GeometryReader { geometry in
                ZStack{
                    Color.Glitter
//                    .aspectRatio(geometry.size, contentMode: .fill)
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
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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
