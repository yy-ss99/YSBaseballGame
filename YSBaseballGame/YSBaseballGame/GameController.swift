//
//  GameController.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

/// 게임에 관련된 것을 관리
final class GameController {
    private let rule: GameRule
    private var game: BaseballGame
    private var gameHistory = GameHistory()
    
    init(rule: GameRule) { // 게임 룰은 바뀔 수도 있으니 주입하겠다는 표현
        self.rule = rule
        self.game = BaseballGame(rule: rule)
    }
    
    func showMenu() {
        var isMenuShowing = true
        
        while isMenuShowing {
            print(UserInstruction.mainMenu, terminator: "")
            guard let menuChoice = readLine() else { return }
            
            switch menuChoice {
            case MenuChoice.start.rawValue:
                print(UserInstruction.startOption)
                let attempt = game.startGame()
                gameHistory.countOrder()
                gameHistory.saveGameRecord(attempt: attempt)
            case MenuChoice.record.rawValue:
                print(UserInstruction.gameRecordOption)
                gameHistory.showRecord()
            case MenuChoice.end.rawValue:
                gameHistory.resetGameRecord()
                print(UserInstruction.endOption)
                isMenuShowing = false
            default:
                print(UserInstruction.wrongInput)
                continue
            }
        }
    }
    
}
