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


func getGameResults(of userNumbers: [Int]) -> (Int, Int) {
    let sameNumbers = baseballGame.computerNumbers.filter { userNumbers.contains($0) }
    var strikeCount = 0
    var ballCount = 0
    
    for num in sameNumbers {
        if baseballGame.computerNumbers.firstIndex(of: num) == userNumbers.firstIndex(of: num) {
            strikeCount += 1
        }
    }
    ballCount = sameNumbers.count - strikeCount
    
    return (strikeCount, ballCount)
}

func cleanNumbers(with input:String) -> [Int]? {
    let cleanedNumbers = input.split(separator: "").compactMap { Int($0) }
    
    if cleanedNumbers.count > gameRule.digit.rawValue
        || Set(cleanedNumbers).count != gameRule.digit.rawValue {
        return nil
    } else {
        return cleanedNumbers
    }
}
