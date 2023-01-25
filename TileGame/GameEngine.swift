//
//  GameEngine.swift
//  TileGame
//
//  Created by Chandrachudh K on 13/01/23.
//

import Foundation
import Combine
import SwiftUI

enum Direction: CaseIterable {
    case north
    case east
    case west
    case south
}

class TileViewModel: ObservableObject {
    @Published var hasPlank: Bool
    @Published var hasUser: Bool
    let isCenterTile: Bool
    
    init(hasPlank: Bool, hasUser: Bool, isCenterTile: Bool) {
        self.hasPlank = hasPlank
        self.hasUser = hasUser
        self.isCenterTile = isCenterTile
    }
}

class GameEngine: ObservableObject {
    @Published var currentStep = 0
    private let tilePositions = [
        [1,1,0,0,0,1,1],
        [1,0,0,0,0,0,1],
        [0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0],
        [1,0,0,0,0,0,1],
        [1,1,0,0,0,1,1]]
    @Published var userPosition = (row: 0, colom: 0)
    @Published var tileInfo = [[TileViewModel]]()
    @Published var didWin = false
    @Published var highScore = "-"
    
    let colomsCount = 7
    let rowsCount = 9
    
    private var hasUserinteraction: Bool = true {
        didSet {
            if hasUserinteraction {
                let currentTile = tileInfo[userPosition.row][userPosition.colom]
                if currentTile.isCenterTile {
                    didWin = true
                }
            }
        }
    }
    
    init() {
        for i in 0..<self.rowsCount {
            var array = [TileViewModel]()
            for j in 0..<self.colomsCount {
                let item = self.tilePositions[i][j]
                array.append(TileViewModel(hasPlank: item == 1, hasUser: hasUserAt(row: i, colom: j), isCenterTile: j == colomsCount/2 && i == rowsCount/2))
            }
            tileInfo.append(array)
        }
    }
    
    func reset() {
        hasUserinteraction = false
        userPosition = (row: 0, colom: 0)
        for i in 0..<rowsCount {
            for j in 0..<colomsCount {
                tileInfo[i][j].hasUser = userPosition.row == i && userPosition.colom == j
                tileInfo[i][j].hasPlank = tilePositions[i][j] == 1
            }
        }
        hasUserinteraction = true
        currentStep = 0
        didWin = false
    }
    
    func hasUserAt(row: Int, colom: Int) -> Bool {
        row == userPosition.row && colom == userPosition.colom
    }
    
    func moveDirection(direction: Direction) {
        if !hasUserinteraction {
            return
        }
        hasUserinteraction = false
        var newUserPosition = (row: 0, colom: 0)
        
        switch direction {
        case .north:
            if userPosition.row > 0 {
                newUserPosition = (row: userPosition.row - 1, colom: userPosition.colom)
            } else {
                hasUserinteraction = true
                return
            }
        case .east:
            if userPosition.colom < colomsCount - 1 {
                newUserPosition = (row: userPosition.row, colom: userPosition.colom + 1)
            } else {
                hasUserinteraction = true
                return
            }
        case .west:
            if userPosition.colom > 0 {
                newUserPosition = (row: userPosition.row, colom: userPosition.colom - 1)
            } else {
                hasUserinteraction = true
                return
            }
        case .south:
            if userPosition.row < rowsCount - 1 {
                newUserPosition = (row: userPosition.row + 1, colom: userPosition.colom)
            } else {
                hasUserinteraction = true
                return
            }
        }
        
        if canUserMoveToNewPosition(newUserPosition: newUserPosition) {
            changeUserPosition(newUserPosition: newUserPosition)
            hasUserinteraction = true
        } else {
            // Move the plank with user in the same direction until there is another plank
            moveUserWithPlank(in: direction)
        }
    }
    
    private func moveUserWithPlank(in direction: Direction) {
        var nextPosition = (row: 0, colom: 0)
        switch direction {
        case .north:
            nextPosition = (row:max(userPosition.row - 1, 0), colom:userPosition.colom)
        case .east:
            nextPosition = (row:userPosition.row, colom: min(userPosition.colom + 1, colomsCount-1))
        case .west:
            nextPosition = (row:userPosition.row, colom:max(userPosition.colom - 1, 0))
        case .south:
            nextPosition = (row:min(userPosition.row + 1, rowsCount-1), colom:userPosition.colom)
        }
        
        let currentTileInfo = tileInfo[userPosition.row][userPosition.colom]
        let nextTileInfo = tileInfo[nextPosition.row][nextPosition.colom]
        if !nextTileInfo.hasPlank {
            print("\n")
            userPosition = nextPosition
            withAnimation(.easeInOut(duration: 0.25)) {
                currentTileInfo.hasPlank = false
                currentTileInfo.hasUser = false
                nextTileInfo.hasPlank = true
                nextTileInfo.hasUser = true
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.moveUserWithPlank(in: direction)
                }
            }
        } else {
            hasUserinteraction = true
        }
    }
    
    private func canUserMoveToNewPosition(newUserPosition: (row: Int, colom: Int)) -> Bool {
        tileInfo[newUserPosition.row][newUserPosition.colom].hasPlank
    }
    
    private func changeUserPosition(newUserPosition: (row: Int, colom: Int)) {
        removeUser()
        userPosition = newUserPosition
        addUser()
    }
    
    private func removeUser() {
        withAnimation(.easeInOut(duration: 0.25)) {
            tileInfo[userPosition.row][userPosition.colom].hasUser = false
        }
    }
    
    private func addUser() {
        withAnimation(.easeInOut(duration: 0.25)) {
            tileInfo[userPosition.row][userPosition.colom].hasUser = true
            currentStep += 1
            hasUserinteraction = true
        }
    }
}
