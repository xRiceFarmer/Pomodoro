//
//  TimerCardView.swift
//  Pomodoro
//
//  Created by Thái Khang on 15/01/2024.
//

import SwiftUI
import ActivityKit

struct TimerCardView: View {
    @StateObject var pomodoroTimer = PomodoroTimer()
    @State private var isTrackingTime: Bool = false
    
    @State private var endTime: Date? = nil
    @State private var activity: Activity<TimerAttributes>? = nil
    
    let selectecTab: Tab
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(selectecTab.mainColor)
            VStack {
                if let endTime {
                    Text(endTime, style: .relative)
                }
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                    .overlay {
                        Button(action: {
                            
                            isTrackingTime.toggle()
                            
                            if isTrackingTime {
                                for activity in Activity<TimerAttributes>.activities {
                                    Task {
                                        await activity.end(nil, dismissalPolicy: .immediate)
                                    }
                                }
                                
                                endTime = Date().addingTimeInterval(10)
                                let attributes = TimerAttributes()
                                guard let endTime else { return }
                                let state = TimerAttributes.ContentState(endTime: endTime)
                                let content = ActivityContent(state: state, staleDate: nil)
                                activity = try? Activity.request(attributes: attributes, content: content, pushType: nil)
                                
                                
                            } else {
                                
                                
                                guard let endTime else { return }
                                let finalState = TimerAttributes.ContentState(endTime: endTime)
                                Task {
                                    await activity?.end(ActivityContent(state: finalState, staleDate: .now), dismissalPolicy: .immediate)
                                    print("attempted to end activity")
                                }
                                print("isTrackingTime: \(isTrackingTime)")
                                self.endTime = nil
                            }
                        }) {
                            Image(systemName: isTrackingTime ? "stop.circle.fill" : "play.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                        }
                    }
                .padding()
            }
        }
    }
}

#Preview {
    TimerCardView(selectecTab: .pomodoro)
}
