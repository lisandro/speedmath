//
//  TypingWindow.swift
//  SpeedMath
//
//  Created by Lisandro Falconi on 21/03/2020.
//  Copyright © 2020 Lisandro Falconi. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let enterNumber = Notification.Name("enterNumber")
    static let removeNumber = Notification.Name("removeNumber")
    static let submitAnswer = Notification.Name("submitAnswer")
}

class TypingWindow: NSWindow {
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 51 {
            NotificationCenter.default.post(.init(name: .removeNumber, object: nil, userInfo: nil))
        } else if event.keyCode == 36 {
            NotificationCenter.default.post(.init(name: .submitAnswer, object: nil, userInfo: nil))
        } else {
            guard let characters = event.characters else { return }

            if let number = Int(characters) {
                NotificationCenter.default.post(name: .enterNumber, object: number)
            }
        }
    }
}
