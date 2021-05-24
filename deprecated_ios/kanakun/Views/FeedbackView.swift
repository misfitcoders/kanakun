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
            .font(.title)
        Text("practice identifying japanese kanas")
            .font(.subheadline)
            .bold()
            .offset(x: 0, y: -20)
        Text(
"""
In the upper area you will see the characters to identify along with an indicator that shows the current character in play. Right below there is a collection of buttons for which to tap the correct character.
You can change the characters shown in both the indicator area and the character pad by taping on the arrows button of the bottom toolbar.
There is a book button that shows the original text and its reading format, along with all the sense definitions attributed to it.
The numbered circle of the bottom toolbar will count every failed attempt, and the bouncing arrow will skip the current content bein played.
"""         )
            .lineSpacing(4.0)
            .multilineTextAlignment(.leading)
            .font(.system(size: 14))

             Text("For support or to kindly send some feedback, please contact us on:")
                .font(.system(size: 14))
             Text("support@misfitcoders.com")
                .font(.caption)
                .bold()
            Spacer()
            Text(
"""
This application (Kana Kun) does not perform third–party data collection of any sort, and does not include third–party advertising of any form. The data collected will never leave the device, hence will never be shared with anyone.
"""
            )
                .font(.system(size: 10))
                .foregroundColor(Color.gray)
                .padding(.bottom, 40)
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


