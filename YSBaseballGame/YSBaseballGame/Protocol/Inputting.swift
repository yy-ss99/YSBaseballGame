//
//  inputting.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/19/26.
//

protocol Inputting {
    var rule: GameRule { get }
    func cleanNumbers(with input:String) -> [Int]?
    func readLine() -> String?
}

extension Inputting {
    func cleanNumbers(with input:String) -> [Int]? {
        let cleanedNumbers = input.split(separator: "").compactMap { Int($0) }
        
        if cleanedNumbers.count != rule.digit.rawValue
            || Set(cleanedNumbers).count != rule.digit.rawValue {
            return nil
        } else {
            return cleanedNumbers
        }
    }
}

struct InputManager: Inputting {
    var rule: GameRule
    func readLine() -> String? {
        Swift.readLine()
    }
}
