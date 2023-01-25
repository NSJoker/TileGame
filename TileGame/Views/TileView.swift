//
//  TileView.swift
//  TileGame
//
//  Created by Chandrachudh K on 13/01/23.
//

import SwiftUI

struct TileView: View {
    @ObservedObject var tileViewModel: TileViewModel
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var counter: Int = 0
    
    var body: some View {
        ZStack {
            tileViewModel.hasPlank ? Color.white : Color.white.opacity(0.3)
            if tileViewModel.isCenterTile {
                Image(systemName: "crown.fill")
                    .font(.title.bold())
                    .foregroundColor(getColor())
                    .shadow(radius: 5)
                    .onReceive(timer) { _ in
                        counter += 1
                        if counter > 2 {
                            counter = 0
                        }
                    }
            }
            if tileViewModel.hasUser {
                Image(systemName: "person.fill")
                    .foregroundColor(.black)
                    .font(.title.bold())
            }
        }
    }
    
    private func getColor() -> Color {
        switch counter {
        case 1:
            return .purple
        case 2:
            return .white
        default:
            return .cyan
        }
    }
}
