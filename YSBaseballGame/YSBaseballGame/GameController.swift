//
//  GameController.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/15/26.
//

/// 게임에 대한 것들을 컨트롤해줌
final class GameController {
    private let rule: GameRule
    private var game: BaseballGame
    private var gameHistory = GameHistory()
    
    init(rule: GameRule) { // 외부에서 정한 규칙을 받아서 주입 
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
