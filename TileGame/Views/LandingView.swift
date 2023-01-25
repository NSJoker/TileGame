//
//  LandingView.swift
//  TileGame
//
//  Created by Chandrachudh K on 16/01/23.
//

import SwiftUI

struct LandingView: View {
    @State var titleCounter: Int = 0
    @State var showHowToPlay = false
    @Binding var startGame: Bool
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            // Title
            TitleView(title: "THE CROWN OF LANKA!")
                .padding(.vertical, 30)
                .onAppear {
                    AudioPlayer.shared.playThemeTrack()
                }
                .onReceive(timer) { _ in
                    titleCounter += 1
                    if titleCounter > 2 {
                        titleCounter = 0
                    }
                }
            
            LogoView()
                .padding(.top, 40)
            
            Text("How to play?")
                .ailerons(20)
                .foregroundColor(.white)
                .onTapGesture {
                    showHowToPlay = true
                }

            Text("Start Game")
                .arcadia(40)
                .foregroundColor(.white)
                .padding(.top, 60)
                .onTapGesture {
                    startGame = true
                }
            
            Spacer()
            
            Text("Developed by Chandrachudh.K")
                .ailerons(16)
                .foregroundColor(.white)
                .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    func TitleView(title: String) -> some View {
        let fontSize: CGFloat = 50
        
        ZStack {
            Text(title)
                .arcadia(fontSize)
                .multilineTextAlignment(.center)
                .foregroundColor(.purple)
                .offset(x: -6, y: 6)
            
            Text(title)
                .arcadia(fontSize)
                .multilineTextAlignment(.center)
                .foregroundColor(.cyan)
                .offset(x: -3, y: 3)
                .opacity(titleCounter > 0 ? 1 : 0)
            
            Text(title)
                .arcadia(fontSize)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .opacity(titleCounter == 2 ? 1 : 0)
        }
    }
    
    @ViewBuilder
    func LogoView() -> some View {
        let logoSize: CGFloat = 150
        let logoDimension: CGFloat = 200
        
        ZStack {
            Image(systemName: "crown.fill")
                .font(.system(size: logoSize, weight: .bold, design: .rounded))
                .foregroundColor(.purple)
                .frame(width: logoDimension, height: logoDimension)
                .offset(x: -6, y: 6)
            
            Image(systemName: "crown.fill")
                .font(.system(size: logoSize, weight: .bold, design: .rounded))
                .foregroundColor(.cyan)
                .frame(width: logoDimension, height: logoDimension)
                .offset(x: -3, y: 3)
                .opacity(titleCounter > 0 ? 1 : 0)
            
            Image(systemName: "crown.fill")
                .font(.system(size: logoSize, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: logoDimension, height: logoDimension)
                .opacity(titleCounter == 2 ? 1 : 0)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(startGame: .constant(false))
    }
}
