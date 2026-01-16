//
//  GameHistory.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

class GameHistory {
    var gameCount = 0 // BaseballGame 에서 세어야 함
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
    
    func showGameRecord(num: Int, gameRecord: [Int: Int]) -> String {
        return "\(num)번째 게임 : \(gameRecord[num]!) 번 시도"
    }
    
    func saveGameRecord() {
        gameRecord[gameOrder] = gameCount
    }
    
    func resetGameRecord() {
        gameRecord = [:]
    }
    
}
