//
//  BaseballGame.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//


/// 야구게임 클래스
final class BaseballGame: NumberGenerating {
    let rule: GameRule
    private let judge = Judge()
    
    init(rule: GameRule) { // 게임 룰은 바뀔 수도 있으니 주입하겠다는 표현
        self.rule = rule
    }
    
    /// 숫자야구게임을 실행하는 함수
    /// - Returns: 사용자가 답을 맞추기 위해 시도한 횟수
    func startGame() -> Int {
        var isGameOn = true
        let computerNumbers = makeRandomNumberWithZero()
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

    
    /// 사용자에게 받은 숫자를 정답과 비교하기 좋게 만들어주는 기능 (클래스 내에서만 쓰임)
    /// - Parameter input: 유저가 입력한 String
    /// - Returns: 잘못된 값이면 nil, 반환 올바른 값이면 숫자 array
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
