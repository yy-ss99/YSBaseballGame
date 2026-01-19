//
//  NumberGenerating.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

protocol NumberGenerating {
    var rule: GameRule { get }
    func makeRandomNumbers() -> [Int]
    func makeRandomNumberWithZero() -> [Int]
}

extension NumberGenerating {
    func makeRandomNumbers() -> [Int] {
        var randomNumbers = Set<Int>()
        
        while randomNumbers.count < rule.digit.rawValue {
            randomNumbers.insert(Int.random(in: 1...9))
        }
        return Array(randomNumbers)
    }

    func makeRandomNumberWithZero() -> [Int] {
        var randomNumbers = Set<Int>()
        
        while randomNumbers.count < rule.digit.rawValue - 1 {
            randomNumbers.insert(Int.random(in: 0...9))
        }
        var resultNumbers = Array(randomNumbers)
        
        while resultNumbers.count < rule.digit.rawValue {
            let firstNum = Int.random(in: 1...9)
            if !(resultNumbers.contains(firstNum)) {
                resultNumbers.insert(firstNum, at: 0)
            }
        }
        return resultNumbers
    }
}

struct NumberGenerator: NumberGenerating {
    var rule: GameRule
}
