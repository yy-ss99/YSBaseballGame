//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

let gameRule = GameRule(digit: .three)
var gameHistory = GameHistory() // Main = gameController
var baseballGame = BaseballGame()

showMenu()

func showMenu() {
    var isMenuShowing = true
    
    while isMenuShowing {
        print(UserInstruction.mainMenu, terminator: "")
        guard let menuChoice = readLine() else { return }
        
        switch menuChoice {
        case MenuChoice.start.rawValue:
            print(UserInstruction.startOption)
            baseballGame.startGame()
        case MenuChoice.record.rawValue:
            print(UserInstruction.gameRecordOption)
            gameHistory.showRecord()
        case MenuChoice.end.rawValue:
            gameHistory.resetGameRecord()
            print(UserInstruction.endOption)
            isMenuShowing = false
        default:
            print(UserInstruction.wrongInput)
            continue
        }
    }
}
