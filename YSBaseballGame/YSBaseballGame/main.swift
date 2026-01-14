//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

var computerNumbers = makeRandomNumberWithZero()
var gameCount = 0
var gameOrder = 0
var gameRecord = [Int: Int]()
let gameRule = GameRule(digit: .three)

showMenu()

func makeRandomNumbers() -> [Int] {
    var randomNumbers = Set<Int>()
    
    while randomNumbers.count < gameRule.digit.rawValue {
        randomNumbers.insert(Int.random(in: 1...9))
    }
    return Array(randomNumbers)
}

func makeRandomNumberWithZero() -> [Int] {
    var randomNumbers = Set<Int>()
    
    while randomNumbers.count < gameRule.digit.rawValue - 1 {
        randomNumbers.insert(Int.random(in: 0...9))
    }
    var resultNumbers = Array(randomNumbers)
    
    while resultNumbers.count < gameRule.digit.rawValue {
        let firstNum = Int.random(in: 1...9)
        if !(resultNumbers.contains(firstNum)) {
            resultNumbers.insert(firstNum, at: 0)
        }
    }
    return resultNumbers
}

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
            showRecord()
        case MenuChoice.end.rawValue:
            gameRecord = [:]
            print(UserInstruction.endOption)
            isMenuShowing = false
        default:
            print(UserInstruction.wrongInput)
            continue
        }
    }
}

func showRecord() {
    if gameRecord.count == 0 {
        return
    } else {
        for num in 1...gameOrder {
            print(UserInstruction.showGameRecord(num: num, gameRecord: gameRecord))
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
        gameCount += 1
        let (strikeCount, ballCount) = getGameResults(of: cleanedNumbers)
        
        if strikeCount == gameRule.digit.rawValue {
            isGameOn = false
            gameOrder += 1
            gameCount += 1
            print(UserInstruction.gameWin)
            gameRecord[gameOrder] = gameCount
        } else {
            print(UserInstruction.showBallAndStrike(strikeCount: strikeCount, ballCount: ballCount))
        }
    }
    computerNumbers = makeRandomNumberWithZero()
    gameCount = 0
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
