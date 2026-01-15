//
//  BaseballGame.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

struct BaseballGame {
    let numberGenerator = NumberGenerator()
    let judge = Judge()
    var computerNumbers = NumberGenerator().makeRandomNumberWithZero()
    
    mutating func startGame() {
        var isGameOn = true
     
        while isGameOn {
            print(UserInstruction.gameStart, terminator: "")
            
            guard let userInput = readLine(),
                  let cleanedNumbers = cleanNumbers(with: userInput) else {
                print(UserInstruction.wrongInput)
                continue
            }
            gameHistory.gameCount += 1
            
            let result = judge.evaluate(answer: computerNumbers, guess: cleanedNumbers)
            
            if result.strikes == gameRule.digit.rawValue {
                isGameOn = false
                gameHistory.gameOrder += 1
                print(UserInstruction.gameWin)
                gameHistory.saveGameRecord()
            } else {
                print(UserInstruction.showBallAndStrike(strikeCount: result.strikes, ballCount: result.balls))
            }
        }
        resetGame()
    }

    mutating func resetGame() {
        computerNumbers = numberGenerator.makeRandomNumberWithZero()
        gameHistory.gameCount = 0
    }

    func cleanNumbers(with input:String) -> [Int]? {
        let cleanedNumbers = input.split(separator: "").compactMap { Int($0) }
        
        if cleanedNumbers.count != gameRule.digit.rawValue
            || Set(cleanedNumbers).count != gameRule.digit.rawValue {
            return nil
        } else {
            return cleanedNumbers
        }
    }
}
