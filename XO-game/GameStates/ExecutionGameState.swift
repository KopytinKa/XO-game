//
//  ExecutionGameState.swift
//  XO-game
//
//  Created by Кирилл Копытин on 15.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class ExecutionGameState: GameState {
    var isCompleted: Bool = false
    
    private unowned let gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    func begin() {
        self.gameViewController.firstPlayerTurnLabel.isHidden = true
        self.gameViewController.secondPlayerTurnLabel.isHidden = true
        
        self.gameViewController.winnerLabel.isHidden = true
        ExecuteInvoker.shared.execute()
    }
    
    func addMark(at position: GameboardPosition) { }
}
