//
//  Home.swift
//  TileGame
//
//  Created by Chandrachudh K on 13/01/23.
//

import SwiftUI

struct Home: View {
    @ObservedObject var gameEngine = GameEngine()
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 10) {
                    HeaderView()
                        .frame(height: 30)
                        .background(Color.clear)
                    GridView(size: CGSize(width: proxy.size.width, height: proxy.size.height - 200))
                        .background(.clear)
                    HStack(spacing: 5) {
                        let controlSize: CGFloat = 50
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: controlSize, height: controlSize)
                            .overlay {
                                Image(systemName: "arrow.left")
                                    .font(.title.bold())
                                    .foregroundColor(.black)
                            }
                            .onTapGesture {
                                gameEngine.moveDirection(direction: .west)
                            }

                        VStack(spacing: 5) {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: controlSize, height: controlSize)
                                .overlay {
                                    Image(systemName: "arrow.up")
                                        .font(.title.bold())
                                        .foregroundColor(.black)
                                }
                                .onTapGesture {
                                    gameEngine.moveDirection(direction: .north)
                                }
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: controlSize, height: controlSize)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: controlSize, height: controlSize)
                                .overlay {
                                    Image(systemName: "arrow.down")
                                        .font(.title.bold())
                                        .foregroundColor(.black)
                                }
                                .onTapGesture {
                                    gameEngine.moveDirection(direction: .south)
                                }
                        }
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: controlSize, height: controlSize)
                            .overlay {
                                Image(systemName: "arrow.right")
                                    .font(.title.bold())
                                    .foregroundColor(.black)
                            }
                            .onTapGesture {
                                gameEngine.moveDirection(direction: .east)
                            }
                        
                        
                        Spacer()
                    }
                    .background(Color.clear)
                    .frame(height: 150)
                    Spacer()
                }
                
                if gameEngine.didWin {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .overlay {
                            VStack {
                                Text("You Won!")
                                    .font(.system(size: 36))
                                    .foregroundColor(.black)
                                
                                Button {
                                    gameEngine.reset()
                                } label: {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .font(.title.bold())
                                        .foregroundColor(.blue)
                                }

                            }
                        }
                        .frame(width: proxy.size.width - 40)
                        .frame(height: 200)
                        .shadow(radius: 5)
                }
            }
        }
        .padding(16)
        .background(.black)
        
    }
    
    @ViewBuilder
    func GridView(size: CGSize) -> some View {
        let width = size.width / CGFloat(gameEngine.colomsCount)-3
        let height = size.height / CGFloat(gameEngine.rowsCount)-3
            
        VStack(spacing: 3) {
            ForEach(0..<gameEngine.rowsCount, id: \.self) { i in
                HStack(spacing: 3) {
                    ForEach(0..<gameEngine.colomsCount, id: \.self) { j in
                        TileView(tileViewModel: gameEngine.tileInfo[i][j])
                            .frame(width: width, height: height)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Text("HighScore: \(gameEngine.highScore)")
                .foregroundColor(.white)
                .font(.title.bold())
            Spacer()
            Text("Steps: \(gameEngine.currentStep)")
                .foregroundColor(.white)
                .font(.title2.bold())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
