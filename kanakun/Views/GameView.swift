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
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var gameContent: GameContentController
    
    @State var progressValue: Float = 0.4

    @ObservedObject var gamePlay = GamePlayController.game
    
    var bottomBar: some View {
        HStack {
            Button(action: {}) {
                ZStack {
                    Image(systemName: "book.fill")
                        .font(.title)
                        .foregroundColor(.Astronaut)
                        .padding(30)
                }
            }
            Button(action: {
                gamePlay.toggleMode()
            }) {
                ZStack {
                    Image(systemName: "arrow.right.arrow.left.circle.fill")
                        .font(.title)
                        .foregroundColor(.Astronaut)
                        .padding(30)
                }
            }
            Spacer()
            Image(systemName: "\(gamePlay.failed).circle.fill")
                .font(Font.system(.largeTitle).bold())
                .foregroundColor(.PersianPink)
            Spacer()
            Button(action: {
                gameContent.next()
            }) {
                ZStack {
                    Image(systemName: "arrowshape.bounce.right.fill")
                        .font(.title)
                        .foregroundColor(.Astronaut)
                        .padding(30)
                }
            }
        }
    }
    
    var btnBack : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }
        ) {
            Image(systemName: "smallcircle.fill.circle")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    var body: some View {
        if gamePlay.content.isEmpty || gamePlay.success {
           VStack { Text("Loading content") }
            .onAppear { gameContent.next() }
        }
        else {
            GeometryReader { geometry in
                ZStack{
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.GovernorBay, Color.ChetwodeBlue]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        btnBack
                        Spacer()
                        GameIndicator(
                            content: gamePlay
                                .content
                                .enumerated()
                                .map {
                                    EnumeratedToken(
                                        index: $0.offset,
                                        token: $0.element,
                                        mode: gamePlay.mode
                                    )
                                },
                            cursor: gamePlay.cursor
                        )
                        Spacer()
                        GamePad(
                            padItems: gamePlay
                                .padItems
                                .enumerated()
                                .map {
                                    EnumeratedToken(
                                        index: $0.offset,
                                        token: $0.element,
                                        mode: gamePlay.mode
                                    )
                                },
                            checkAnswer: gamePlay.checkAnswer)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.width,
                                alignment: .center)
                         Spacer()

//                        TimerBar(value: $progressValue)
//                            .frame(height: 5)
//                            .padding(.horizontal, 20)

                        //MARK: - Bottom Toolbar
                        bottomBar
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
            game.startGameWith(content: "ていすかんなにまく".tokenizedAll)
        }
    }
}
