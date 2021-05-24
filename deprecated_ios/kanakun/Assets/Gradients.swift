//
//  Gradients.swift
//  kanakun
//
//  Created by Enrique Perez Velasco on 26/07/2020.
//  Copyright © 2020 Misfitcoders. All rights reserved.
//

import SwiftUI

extension LinearGradient {
  public static var DiagonalDarkBorder: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.white, .Nepal]),
      startPoint: UnitPoint(x: -0.2, y: 0.5),
      endPoint: .bottomTrailing
    )
  }

    public static var GreenGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.DarkPastelGreen, .SpringGreen]),
            startPoint: UnitPoint(x: -0.2, y: 0.5),
            endPoint: .bottomTrailing
        )
    }
    
    public static var RedGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.Lust, .TotemPole]),
            startPoint: UnitPoint(x: -0.2, y: 0.5),
            endPoint: .bottomTrailing
        )
    }
  
  public static var DiagonalLightBorder: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.white, .Geyser]),
      startPoint: UnitPoint(x: 0.2, y: 0.2),
      endPoint: .bottomTrailing
    )
  }
  
  public static var HorizontalDark: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.Manatee, .Biscay]),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  public static var HorizontalDarkReverse: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [.Biscay, .Manatee]),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  public static var HorizontalDarkToLight: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [
        .Manatee,
        Color.white.opacity(0.0),
        .white]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  public static var VerticalLightToDark: LinearGradient {
    LinearGradient(
      gradient: Gradient(colors: [
        .white,
        Color.white.opacity(0.0),
        .Manatee]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
  
  public static var HorizontalLight: LinearGradient {
    LinearGradient(
        gradient: Gradient(colors: [.AquaHaze, .Nepal]),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
}


