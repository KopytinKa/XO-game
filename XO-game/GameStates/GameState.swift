//
//  GameState.swift
//  XO-game
//
//  Created by v.prusakov on 9/7/21.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

protocol GameState {
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
}
