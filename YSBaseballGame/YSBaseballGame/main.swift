//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

var computerNumbers = makeRandomNumberWithZero()
showMenu()

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
    
    while resultNumbers.count < 3 {
        let firstNum = Int.random(in: 1...9)
        if !(resultNumbers.contains(firstNum)) {
            resultNumbers.insert(firstNum, at: 0)
        }
    }
    print(resultNumbers)
    return resultNumbers
}

func showMenu() {
    let startOption = "1"
    let gameRecordOption = "2"
    let endOption = "3"
    var isMenuShowing = true
    
    while isMenuShowing {
        print("1. 게임시작 2. 게임기록보기 3. 게임종료\n원하는 기능을 선택해주세요.")
        guard let menuChoice = readLine() else { return }
        
        switch menuChoice {
        case startOption:
            startGame()
        case gameRecordOption:
            print("기록 기능 준비중")
        case endOption:
            isMenuShowing = false
        default:
            print("다시 입력해주세요.")
            continue
        }
    }
}

func startGame() {
    var isGameOn = true
 
    while isGameOn {
        print("⚾️게임을 시작합니다!⚾️\n✏️ 숫자를 입력하세요.")
        
        guard let userInput = readLine(),
              let cleanedNumbers = cleanNumbers(with: userInput) else {
            print("❌ 잘못된 입력입니다. 겹치지 않는 세자리 숫자를 입력해주세요!")
            continue
        }
        
        let (strikeCount, ballCount) = getGameResults(of: cleanedNumbers)
        
        if strikeCount == 3 {
            print("🎉🎉🎉🎉🎉\n🎉 정답입니다!!🎉\n🎉🎉🎉🎉🎉")
            isGameOn = false
        } else {
            print("\(strikeCount)스트라이크 \(ballCount)볼")
        }
    }
    computerNumbers = makeRandomNumberWithZero()
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
