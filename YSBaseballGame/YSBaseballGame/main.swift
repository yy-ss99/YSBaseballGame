//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

let numberGenerator = NumberGenerator()
let gameRule = GameRule(digit: .three) // Game
var computerNumbers = NumberGenerator().makeRandomNumberWithZero() // Game
var gameHistory = GameHistory()

showMenu()

func showMenu() {
    var isMenuShowing = true
    
    while isMenuShowing {
        print(UserInstruction.mainMenu, terminator: "")
        guard let menuChoice = readLine() else { return }
        
        switch menuChoice {
        case MenuChoice.start.rawValue:
            print(UserInstruction.startOption)
            startGame()
        case MenuChoice.record.rawValue:
            print(UserInstruction.gameRecordOption)
            gameHistory.showRecord()
        case MenuChoice.end.rawValue:
            gameHistory.deleteGameRecord()
            print(UserInstruction.endOption)
            isMenuShowing = false
        default:
            print(UserInstruction.wrongInput)
            continue
        }
    }
}


func startGame() {
    var isGameOn = true
 
    while isGameOn {
        print(UserInstruction.gameStart, terminator: "")
        
        guard let userInput = readLine(),
              let cleanedNumbers = cleanNumbers(with: userInput) else {
            print(UserInstruction.wrongInput)
            continue
        }
        gameHistory.gameCount += 1
        let (strikeCount, ballCount) = getGameResults(of: cleanedNumbers)
        
        if strikeCount == gameRule.digit.rawValue {
            isGameOn = false
            gameHistory.gameOrder += 1
            gameHistory.gameCount += 1
            print(UserInstruction.gameWin)
            gameHistory.saveGameRecord()
        } else {
            print(UserInstruction.showBallAndStrike(strikeCount: strikeCount, ballCount: ballCount))
        }
    }
    computerNumbers = numberGenerator.makeRandomNumberWithZero()
    gameHistory.gameCount = 0
}

func getGameResults(of userNumbers: [Int]) -> (Int, Int) {
    let sameNumbers = computerNumbers.filter { userNumbers.contains($0) }
    var strikeCount = 0
    var ballCount = 0
    
    for num in sameNumbers {
        if computerNumbers.firstIndex(of: num) == userNumbers.firstIndex(of: num) {
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
