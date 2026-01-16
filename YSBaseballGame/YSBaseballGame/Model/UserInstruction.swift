//
//  UserInstruction.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

enum UserInstruction: CustomStringConvertible {
    case mainMenu
    case startOption
    case gameRecordOption
    case endOption
    case wrongInput
    case gameStart
    case gameWin

    var description: String {
        switch self {
        case .mainMenu:
            return "🥎숫자 야구 게임🥎\n1. 게임시작 2. 게임기록보기 3. 게임종료\n원하는 기능을 선택해주세요."
        case .startOption:
            return "⚾️게임을 시작합니다!⚾️"
        case .gameRecordOption:
            return "🏆<게임 기록 보기>🏆"
        case .endOption:
            return "게임을 종료합니다."
        case .wrongInput:
            return "❌ 올바른 숫자를 입력해주세요!"
        case .gameStart:
            return "✏️ 숫자를 입력하세요:"
        case .gameWin:
            return "🎉🎉🎉🎉🎉🎉\n🎉정답입니다!🎉\n🎉🎉🎉🎉🎉🎉"
        }
    }
    
    static func showBallAndStrike(strikeCount: Int, ballCount: Int) -> String {
        return "\(strikeCount)스트라이크 \(ballCount)볼"
    }
}
