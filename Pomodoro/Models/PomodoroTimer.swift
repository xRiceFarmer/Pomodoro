//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Thái Khang on 16/01/2024.
//

import Foundation

import SwiftUI

class PomodoroTimer: ObservableObject {
    @Published var secondsElapsed: Int = 0
    @Published var secondsRemaining: Int = 300
    var timer: Timer = Timer()
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
            self.secondsRemaining -= 1
        }
    }

    func stop() {
        timer.invalidate()
        secondsElapsed = 0
    }

    func pause() {
        timer.invalidate()
    }
}
