//
//  main.swift
//  YSBaseballGame
//
//  Created by Yeseul Jang on 1/13/26.
//

import Foundation

let rule = GameRule(digit: .three)
let gameController = GameController(rule: rule)
gameController.showMenu()
