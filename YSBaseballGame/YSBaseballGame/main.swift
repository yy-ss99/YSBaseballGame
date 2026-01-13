//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

let computerNumbers = makeRandomNumberWithZero()
startGame()

func makeRandomNumbers() -> [Int] {
    var randomNumbers = Set<Int>()
    
    while randomNumbers.count < 3 {
        randomNumbers.insert(Int.random(in: 1...9))
    }
    return Array(randomNumbers)
}

func makeRandomNumberWithZero() -> [Int] {
    var randomNumbers = Set<Int>()
    
    while randomNumbers.count < 2 {
        randomNumbers.insert(Int.random(in: 0...9))
    }
    var resultNumbers = Array(randomNumbers)
    resultNumbers.insert(Int.random(in: 1...9), at: 0)

    return resultNumbers
}

func startGame() {
    var isGameOn = true
 
    while isGameOn {
        print("✏️ 숫자를 입력하세요.")
        guard let userInput = readLine(),
              let cleanedNumbers = cleanNumbers(with: userInput) else {
            print("❌ 잘못된 입력입니다. 겹치지 않는 세자리 숫자를 입력해주세요!")
            continue
        }
        
        let (strikeCount, ballCount) = getGameResults(of: cleanedNumbers)
        
        if strikeCount == 3 {
            print("🎉 정답입니다!!")
            isGameOn = false
        } else {
            print("\(strikeCount)스트라이크 \(ballCount)볼")
        }
    }
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
    
    if cleanedNumbers.count > 3 || Set(cleanedNumbers).count != 3 {
        return nil
    } else {
        return cleanedNumbers
    }
}
