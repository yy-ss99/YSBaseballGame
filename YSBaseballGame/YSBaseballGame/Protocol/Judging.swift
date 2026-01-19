//
//  Judging.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/19/26.
//

protocol Judging {
    func evaluate(answer: [Int], guess: [Int]) -> Judgement
}

extension Judging {
    func evaluate(answer: [Int], guess: [Int]) -> Judgement {
        let sameNumbers = answer.filter { guess.contains($0) }
        
        var strikes = 0
        for num in sameNumbers {
            if answer.firstIndex(of: num) == guess.firstIndex(of: num) {
                strikes += 1
            }
        }
        
        let balls = sameNumbers.count - strikes
        return Judgement(strikes: strikes, balls: balls)
    }
}
