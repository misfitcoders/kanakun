//
//  FeedbackView.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 24/07/2020.
//

import SwiftUI

struct FeedbackView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
        Text("Welcome to KanaKun")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        Text("An app to practice identifying japanese kanas")
            .font(.title2)
        Text(
"""
In the framed text box you will see the characters to identify along with an indicator that shows the current character to identify. Right below there is a collection of buttons for which to tap the correct character.
You can change the characters shown in both the indicator frame and the character pad by taping on the arrows button of the bottom toolbar.
There is a book button that shows the original text, its reading format, and the many sense definitions attributed to it.
The pink circle of the bottom toolbar will count every failed attempt, and the bouncing arrow will skip the current content bein played.
"""         )
            .lineSpacing(5.0)
            .multilineTextAlignment(.leading)
            .font(.body)
            Spacer()
             Text("For more support or to kindly send some feedback, please contact us on:")
             Text("support@misfitcoders.com")
            Spacer()
            
        }
        .padding(.horizontal, 30)

    }

}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
            .previewLayout(.sizeThatFits)
    }
}


