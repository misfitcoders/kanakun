//
//  GameDetails.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 24/07/2020.
//

import SwiftUI

struct GameDetails: View {
    
    @State private var backgroundOpacity = 0.0
    @State private var animation: Animation = .easeOut(duration: 0.5)
    
    var slug: String
    var reading: String
    var senses: String
    @Binding var isPresented: Bool
    
    public init(
        slug: String,
        reading: String,
        senses: String,
        isPresented: Binding<Bool>
    ) {
        self.slug = slug
        self.reading = reading
        self.senses = senses
        self._isPresented = isPresented
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
//                    Button(action: { self.isPresented.toggle() }, label: {
//                        Image(systemName: "multiply.circle")
//                            .foregroundColor(.Astronaut)
//                            .padding(.top, 20)
//                    })
                    Spacer()
                    Text(self.slug)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .padding(.all, 20)
                    
                    Text(self.reading)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .padding(.bottom, 40)
                        .padding(.horizontal, 20)
                    Spacer()
                    Text(self.senses.replacingOccurrences(of: "\n", with: "\n—\n"))
                        .font(.system(.body, design: .serif))
                        .multilineTextAlignment(.center)
                        .lineSpacing(15)
                        .padding(EdgeInsets(top: 30, leading: 15, bottom: 60, trailing: 15))
                    Spacer()
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .top
            )
            .background(BlurView(style: .systemThickMaterial))
        }
        .edgesIgnoringSafeArea(.all)
                .transition(.move(edge: .bottom))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            self.backgroundOpacity = 0.1
                        }
                        self.animation = .interactiveSpring()
                    }
                }
    }
}

struct GameDetails_Previews: PreviewProvider {
    static var previews: some View {
        GameDetails(
            slug: "馬子にも衣装",
            reading: "まごにもいしょう",
            senses: """
                anybody can look good with the right clothes
                clothes make the man
                fine feathers make fine birds
                clothes on a packhorse driver
            """,
            isPresented: Binding.constant(true)
        )
        .previewLayout(.sizeThatFits)
    }
}
