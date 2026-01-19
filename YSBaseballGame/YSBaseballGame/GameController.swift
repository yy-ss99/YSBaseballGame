//
//  GameController.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

/// 게임에 대한 것들을 컨트롤해줌
final class GameController {
    private let rule: GameRule
    private var gameHistory = GameHistory()
    private let judge: Judging
    private let numGenerator: NumberGenerating
        
    init(rule: GameRule, judge: Judging = Judge(), numGenerator: NumberGenerating? = nil) { // 외부에서 정한 규칙을 받아서 주입
        self.rule = rule
        self.numGenerator = numGenerator ?? NumberGenerator(rule: rule)
        self.judge = judge
    }
    
    func showMenu() {
        var isMenuShowing = true
        
        while isMenuShowing {
            print(UserInstruction.mainMenu, terminator: "")
            guard let menuChoice = readLine() else { return }
            
            switch menuChoice {
            case MenuChoice.start.rawValue:
                print(UserInstruction.startOption)
                let attempt = startGame()
                gameHistory.countOrder()
                gameHistory.saveGameRecord(attempt: attempt)
                
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
    
    func startGame() -> Int {
        let computerNumbers = numGenerator.makeRandomNumberWithZero()
        let baseballGame = BaseballGame(rule: rule, answer: computerNumbers)
        var guessCount = 0
        var isGameOn = true
     
        while isGameOn {
            print(UserInstruction.gameStart, terminator: "")
            
            guard let userInput = readLine(),
                  let cleanedNumbers = cleanNumbers(with: userInput) else { // GameController
                print(UserInstruction.wrongInput)
                continue
            }
            guessCount += 1
            let result = baseballGame.evaluateOneTurn(guess: cleanedNumbers) // baseballGame
            
            if baseballGame.isUserWin(judgement: result) { // baseball game
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
