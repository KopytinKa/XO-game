//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Кирилл Копытин on 15.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let pressComputerModeSegueIdentifier = "chooseComputerMode"
    let press2PlayersModeSegueIdentifier = "choose2PlayersMode"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameViewController = segue.destination as? GameViewController else { return }
        
        if segue.identifier == pressComputerModeSegueIdentifier {
            gameViewController.gameMode = .computer
        } else if segue.identifier == press2PlayersModeSegueIdentifier {
            gameViewController.gameMode = .twoPlayers
        }
    }
}
