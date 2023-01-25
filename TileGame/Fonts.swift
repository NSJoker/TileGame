//
//  Fonts.swift
//  TileGame
//
//  Created by Chandrachudh K on 16/01/23.
//

import SwiftUI

extension View {
    func arcadia(_ size: CGFloat) -> some View {
        self
            .font(.custom("Arcadia-Regular", size: size))
    }
    
    func ailerons(_ size: CGFloat) -> some View {
        self
            .font(.custom("Ailerons-Regular", size: size))
    }
}
