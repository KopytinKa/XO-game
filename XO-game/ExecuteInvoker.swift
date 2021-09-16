//
//  ExecuteInvoker.swift
//  XO-game
//
//  Created by Кирилл Копытин on 15.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class PlayerMoveCommand {
    private let player: Player
    private let position: GameboardPosition
    private let gameboard: Gameboard
    private let gameboardView: GameboardView
    
    init(player: Player, position: GameboardPosition, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.position = position
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func execute() {
        if !self.gameboardView.canPlaceMarkView(at: self.position) {
            self.gameboardView.removeMarkView(at: self.position)
        }
        self.gameboard.setPlayer(self.player, at: self.position)
        self.gameboardView.placeMarkView(self.player.markViewPrototype, at: self.position)
    }
}

final class ExecuteInvoker {
    
    static let shared = ExecuteInvoker()
    
    private init() { }
    
    private var commands: [PlayerMoveCommand] = []
    
    func addCommand(_ command: PlayerMoveCommand) {
        self.commands.append(command)
    }
    
    func execute() {
        self.commands.enumerated().forEach{ [weak self] command in
            guard let self = self else { return }
            if command.offset < 5 {
                command.element.execute()
                self.commands[command.offset + 5].execute()
            }
        }

        self.commands = []
    }
}

func recordMove(player: Player, position: GameboardPosition, gameboard: Gameboard, gameboardView: GameboardView) {
    let command = PlayerMoveCommand(player: player, position: position, gameboard: gameboard, gameboardView: gameboardView)
    ExecuteInvoker.shared.addCommand(command)
}
