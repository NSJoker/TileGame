//
//  TileGameApp.swift
//  TileGame
//
//  Created by Chandrachudh K on 13/01/23.
//

import SwiftUI

@main
struct TileGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .navigationTitle("Crown of Lanka")
        }
        .windowStyle(.titleBar)
        .windowResizability(.contentSize)
    }
}
