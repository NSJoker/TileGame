//
//  ContentView.swift
//  TileGame
//
//  Created by Chandrachudh K on 13/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var startGame: Bool = false
    @State var selectLevel: Bool = false
    
    private let viewWidth: CGFloat = 380
    private let viewHeight: CGFloat = 660
    
    var body: some View {
        if selectLevel {
            LevelSelectionView()
                .preferredColorScheme(.dark)
                .frame(width: viewWidth, height: viewHeight)
//            Home()
//                .preferredColorScheme(.dark)
//                .frame(width: viewWidth, height: viewHeight)
        } else {
            LandingView(startGame: $selectLevel)
                .preferredColorScheme(.dark)
                .frame(width: viewWidth, height: viewHeight)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
