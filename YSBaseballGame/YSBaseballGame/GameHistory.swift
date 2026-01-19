//
//  GameHistory.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//


/// 게임의 결과를 저장하는 객체
final class GameHistory {
    private var gameOrder = 0
    private var gameRecord = [Int: Int]()
    
    func showRecord() {
        guard !gameRecord.isEmpty else { return }
        
        for num in 1...gameOrder {
            print(showGameRecord(num: num, gameRecord: gameRecord))
        }
    }
    
    func countOrder() {
        gameOrder += 1
    }
    
    func showGameRecord(num: Int, gameRecord: [Int: Int]) -> String {
        let attempt = gameRecord[num] ?? 0
        return "\(num)번째 게임 : \(attempt) 번 시도"
    }
    
    func saveGameRecord(attempt: Int) {
        gameRecord[gameOrder] = attempt
    }
    
    func resetGameRecord() {
        gameOrder = 0
        gameRecord.removeAll()
    }
}
