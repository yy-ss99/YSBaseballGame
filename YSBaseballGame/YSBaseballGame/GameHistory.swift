//
//  GameHistory.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

struct GameHistory {
    var gameCount = 0
    var gameOrder = 0
    var gameRecord = [Int: Int]()
    
    func showRecord() {
        if gameRecord.count == 0 {
            return
        } else {
            for num in 1...gameOrder {
                print(UserInstruction.showGameRecord(num: num, gameRecord: gameRecord))
            }
        }
    }
    
    mutating func saveGameRecord() {
        gameRecord[gameOrder] = gameCount
    }
    
    mutating func deleteGameRecord() {
        gameRecord = [:]
    }
    
}
