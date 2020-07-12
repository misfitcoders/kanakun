//
//  ContentView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 12/07/2020.
//

import SwiftUI
import Jisho

struct ContentView: View {
    private let padItems =
        "い す か ん な に ら せ ち と し ハ ン ナ マ も ソ チ サ ひ"
        .components(separatedBy: " ")
    let layout = [GridItem(
        .adaptive(minimum: 80, maximum: 150),
        spacing: 0,
        alignment: .center
    )]
    
    func furiganaEntry() -> AnyView {
        return AnyView(
            VStack{
            Text("ka na")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(.Astronaut)
            Text("国")
                .font(.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(.Astronaut)
        })
    }
    
    var body: some View {
        
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
                    Spacer()
                    //MARK: - Test Indicator
                    VStack {
                        HStack {
                            furiganaEntry()
                            furiganaEntry()
                            furiganaEntry()
                            furiganaEntry()
                            furiganaEntry()
                        }
                        HStack {
                            furiganaEntry()
                            furiganaEntry()
                            furiganaEntry()
                            furiganaEntry()
                        }
                    }
                    .frame(
                        width: geometry.size.width - 40,
                        height: ((geometry.size.width - 20)/4)*2,
                        alignment: .center
                    )
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color.PersianPink,
                                    Color.FrenchRose]
                            ),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(13.0)
                    //MARK: - Kana Pad
                    LazyVGrid(columns: layout, spacing: 10) {
                        ForEach(padItems, id: \.self) { item in
                            Button(action: {}) {
                                Text(item)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.Turquoise)
                                    .frame(
                                        width: (geometry.size.width / 4),
                                        height:  (geometry.size.width / 5),
                                        alignment: .center
                                    )
                            }
                        }
                    }
                    Spacer()
                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                        .padding(.top, 15)
                        .accentColor(.FrenchRose)
                    //MARK: - Bottom Toolbar
                    HStack {
                        Button(action: {}) {
                        ZStack{
                            Image(systemName: "book.fill")
                                .font(.title)
                                .foregroundColor(.Astronaut)
                                .padding(30)
                        }
                    }
                        Spacer()
                        Image(systemName: "10.circle.fill")
                            .font(Font.system(.largeTitle).bold())
                            .foregroundColor(.FrenchRose)
                        Spacer()
                        Button(action: {}) {
                        ZStack{
                            Image(systemName: "arrowshape.bounce.right.fill")
                                .font(.title)
                                .foregroundColor(.Astronaut)
                                .padding(30)
                                
                        }
                    }
                    }
                    

                }
            }
        //MARK: - geometry reader end
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
