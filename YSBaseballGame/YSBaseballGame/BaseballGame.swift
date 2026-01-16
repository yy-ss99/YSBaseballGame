//
//  BaseballGame.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

final class BaseballGame {
    private let rule: GameRule
    private let numberGenerator: NumberGenerator
    private let judge = Judge()
    
    init(rule: GameRule) { // 게임 룰은 바뀔 수도 있으니 주입하겠다는 표현
        self.rule = rule
        self.numberGenerator = NumberGenerator(rule: rule)
    }

    func startGame() -> Int {
        var isGameOn = true
        let computerNumbers = numberGenerator.makeRandomNumberWithZero()
        var guessCount = 0
     
        while isGameOn {
            print(UserInstruction.gameStart, terminator: "")
            
            guard let userInput = readLine(),
                  let cleanedNumbers = cleanNumbers(with: userInput) else {
                print(UserInstruction.wrongInput)
                continue
            }
            guessCount += 1
            let result = judge.evaluate(answer: computerNumbers, guess: cleanedNumbers)
            
            if result.strikes == rule.digit.rawValue {
                isGameOn = false
                print(UserInstruction.gameWin)
            } else {
                print(UserInstruction.showBallAndStrike(strikeCount: result.strikes, ballCount: result.balls))
            }
        }
        return guessCount
    }

    private func cleanNumbers(with input:String) -> [Int]? {
        let cleanedNumbers = input.split(separator: "").compactMap { Int($0) }
        
        if cleanedNumbers.count != rule.digit.rawValue
            || Set(cleanedNumbers).count != rule.digit.rawValue {
            return nil
        } else {
            return cleanedNumbers
        }
    }
}
