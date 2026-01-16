//
//  GameController.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

/// 게임에 관련된 것을 관리
final class GameController {
    private let rule: GameRule
    private var history = GameHistory()
    private var game: BaseballGame
    
    init(rule: GameRule) {
        self.rule = rule
        self.game = BaseballGame()
    }
}
