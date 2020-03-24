//
//  Question.swift
//  SpeedMath
//
//  Created by Lisandro Falconi on 22/03/2020.
//  Copyright © 2020 Lisandro Falconi. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let actualAnswer: String
    var userAnswer = ""
    var paddingAmount = 0

    init() {
        let left = Int.random(in: 1...10)
        let right = Int.random(in: 1...10)

        text = "\(left) + \(right) = "
        actualAnswer = "\(left + right)"
        if left < 10 {
            paddingAmount += 1
        }

        if right < 10 {
            paddingAmount += 1
        }
    }
}
