//
//  BaseballGame.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

struct BaseballGame {
    let rule: GameRule
    let judge = Judge()
    let answer: [Int]
    
    func evaluateOneTurn(guess: [Int]) -> Judgement {
        return judge.evaluate(answer: answer, guess: guess)
    }
    
    func isUserWin(judgement: Judgement) -> Bool {
        judgement.strikes == rule.digit.rawValue
    }
}
