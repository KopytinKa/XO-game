//
//  ComputerInputGameState.swift
//  XO-game
//
//  Created by Кирилл Копытин on 15.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class ComputerInputGameState: GameState {
    var isCompleted: Bool = false
    
    let player: Player = .second
    private unowned let gameViewController: GameViewController
    private let gameboard: Gameboard
    private let gameboardView: GameboardView
    private var markPrototype: MarkView {
        get {
            return player.markViewPrototype
        }
    }
    
    init(gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
        
    func begin() {
        self.gameViewController.firstPlayerTurnLabel.isHidden = true
        self.gameViewController.secondPlayerTurnLabel.isHidden = false
        
        self.gameViewController.winnerLabel.isHidden = true
        
        while (!isCompleted) {
            let position = generateRandomPosition()
            self.addMark(at: position)
        }
    }
    
    private func generateRandomPosition() -> GameboardPosition {
        return GameboardPosition(column: Int.random(in: 0...2), row: Int.random(in: 0...2))
    }
    
    func addMark(at position: GameboardPosition) {
        guard self.gameboardView.canPlaceMarkView(at: position) else { return }
        
        recordEvent(.turnPlayer(player: self.player, position: position))
        
        self.gameboard.setPlayer(self.player, at: position)
        self.gameboardView.placeMarkView(markPrototype.copy(), at: position)
        
        self.isCompleted = true
    }
}
