//
//  ProgressBar.swift
//  Pomodoro
//
//  Created by Thái Khang on 30/01/2024.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var lengthInMinutes: Int
    @Binding var secondsElapsed: Int
    

    
    @State private var offset: CGFloat = 200.0
    var color: Color = Color.green
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundStyle(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(calculateProgress(lengthInMinutes: lengthInMinutes, secondsElapsed: secondsElapsed), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(Animation.easeInOut(duration: 2.0), value: offset)
        }
    }
    func calculateProgress(lengthInMinutes: Int, secondsElapsed: Int) -> Float {
        let totalDurationInSeconds = lengthInMinutes * 60
        let elapsedDurationInSeconds = secondsElapsed
        let progress = Float(elapsedDurationInSeconds) / Float(totalDurationInSeconds)
        return min(max(progress, 0.0), 1.0) // Ensure progress is between 0.0 and 1.0
    }
}

#Preview {
    ProgressBar(lengthInMinutes: .constant(2), secondsElapsed: .constant(20))
}
