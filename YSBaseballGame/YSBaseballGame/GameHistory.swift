//
//  GameHistory.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

final class GameHistory {
    private(set) var gameOrder = 0
    private(set) var gameRecord = [Int: Int]()
    
    func showRecord() {
        if gameRecord.count == 0 {
            return
        } else {
            for num in 1...gameOrder {
                print(showGameRecord(num: num, gameRecord: gameRecord))
            }
        }
    }
    
    func countOrder() {
        return gameOrder += 1
    }
    
    func showGameRecord(num: Int, gameRecord: [Int: Int]) -> String {
        return "\(num)번째 게임 : \(gameRecord[num]!) 번 시도"
    }
    
    func saveGameRecord(attempt: Int) {
        gameRecord[gameOrder] = attempt
    }
    
    func resetGameRecord() {
        gameRecord = [:]
    }
    
}
