//
//  Router.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 26/07/2020.
//  Copyright © 2020 Misfitcoders. All rights reserved.
//

import SwiftUI
import Combine

enum Route: String {
    case root
    case game
}

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: Route = .root {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
}
