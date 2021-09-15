//
//  WinnerGameState.swift
//  XO-game
//
//  Created by Кирилл Копытин on 15.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class WinnerGameState: GameState {
    
    var isCompleted: Bool = false
    
    private let winner: Player?
    private unowned let gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController?) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        
        recordEvent(.gameFinished(winner: self.winner))
        
        if let winner = self.winner {
            self.gameViewController?.winnerLabel.text = self.winnerPlayerName(for: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
    }
    
    func addMark(at position: GameboardPosition) { }
    
    private func winnerPlayerName(for winner: Player) -> String {
        switch winner {
        case .first: return "1st player"
        case .second: return "2nd player"
        }
    }
}
