//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Thái Khang on 16/01/2024.
//

import Foundation

@MainActor
final class PomodoroTimer: ObservableObject {
    @Published var shouldResetTimer = false
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    @Published var timerFired = false
    private(set) var lengthInMinutes: Int
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    
    private var frequency: TimeInterval { 1.0 }

    private weak var timer: Timer?
    private var startDate: Date?

    init(lengthInMinutes: Int = 0) {
        self.lengthInMinutes = lengthInMinutes
        secondsRemaining = lengthInSeconds
    }

    func startCountdown() {
        timerFired = true
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
    }
    
    func stopCountdown(){
        timer?.invalidate()
    }
    nonisolated private func update() {

        Task { @MainActor in
            secondsElapsed += 1
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)
        }
    }
    
    func reset(lengthInMinutes: Int){
        timerFired = false
        self.lengthInMinutes = lengthInMinutes
        secondsRemaining = lengthInSeconds
        secondsElapsed = 0
    }
}
