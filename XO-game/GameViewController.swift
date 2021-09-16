//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    var gameMode: GameMode = .twoPlayers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboardView.clear()
        self.gameboard.clear()
        
        recordEvent(.restartGame)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Game state
    
    private func goToFirstState() {
        let player = Player.first
        
        switch self.gameMode {
        case .computer:
            self.currentState = PlayerInputGameState(
                player: player,
                markPrototype: player.markViewPrototype,
                gameViewController: self,
                gameboard: self.gameboard,
                gameboardView: self.gameboardView
            )
        case .twoPlayers:
            self.currentState = MultiplePlayerInputGameState(
                player: player,
                markPrototype: player.markViewPrototype,
                gameViewController: self,
                gameboard: self.gameboard,
                gameboardView: self.gameboardView
            )
        }
    }
    
    private func goToNextState() {
        
        switch self.gameMode {
        case .computer:
            if let winner = self.referee.determineWinner() {
                self.currentState = WinnerGameState(winner: winner, gameViewController: self)
                return
            }
            
            if (self.currentState as? PlayerInputGameState) != nil {
                self.currentState = ComputerInputGameState(
                    gameViewController: self,
                    gameboard: self.gameboard,
                    gameboardView: self.gameboardView
                )
                self.goToNextState()
            } else if let computerInputState = self.currentState as? ComputerInputGameState {
                let nextPlayer = computerInputState.player.next
                self.currentState = PlayerInputGameState(
                    player: nextPlayer,
                    markPrototype: nextPlayer.markViewPrototype,
                    gameViewController: self,
                    gameboard: self.gameboard,
                    gameboardView: self.gameboardView
                )
            }
        case .twoPlayers:
            if let playerInputState = self.currentState as? MultiplePlayerInputGameState {
                self.gameboardView.clear()
                self.gameboard.clear()
                
                let nextPlayer = playerInputState.player.next
                if nextPlayer != .first {
                    self.currentState = MultiplePlayerInputGameState(
                        player: nextPlayer,
                        markPrototype: nextPlayer.markViewPrototype,
                        gameViewController: self,
                        gameboard: self.gameboard,
                        gameboardView: self.gameboardView
                    )
                } else {
                    self.currentState = ExecutionGameState(gameViewController: self)
                }
            }
            
            if (self.currentState as? ExecutionGameState) != nil, let winner = self.referee.determineWinner() {
                self.currentState = WinnerGameState(winner: winner, gameViewController: self)
                return
            }
        }
    }
}

