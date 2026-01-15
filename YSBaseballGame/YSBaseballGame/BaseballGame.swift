//
//  BaseballGame.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

struct BaseballGame {
    let numberGenerator = NumberGenerator()
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
            let (strikeCount, ballCount) = getGameResults(of: cleanedNumbers)
            
            if strikeCount == gameRule.digit.rawValue {
                isGameOn = false
                gameHistory.gameOrder += 1
                print(UserInstruction.gameWin)
                gameHistory.saveGameRecord()
            } else {
                print(UserInstruction.showBallAndStrike(strikeCount: strikeCount, ballCount: ballCount))
            }
        }
        resetGame()
    }

    mutating func resetGame() {
        computerNumbers = numberGenerator.makeRandomNumberWithZero()
        gameHistory.gameCount = 0
    }
}
