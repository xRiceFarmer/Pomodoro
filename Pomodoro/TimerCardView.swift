
import SwiftUI
import ActivityKit
import Foundation
import UserNotifications

struct TimerCardView: View {
    @Binding var tabs : [TabDetails]

    @Binding var selectedTab: TabDetails
    @Binding var lengthInMinutes: Int
    @State private var isTrackingTime: Bool = false
    @State private var endTime: Date? = nil
    @State private var activity: Activity<TimerAttributes>? = nil
    @State private var timer: Timer? = nil
    @StateObject var pomodoroTimer : PomodoroTimer
    
    @State private var notificationDate: Date = Date()
    
    @Binding var newTimerStarted : Bool

    //@State private var secondsElapsedCache = 0
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(selectedTab.theme.mainColor)
            VStack {
                HStack{
                    Spacer()
                    Button(action:{
                        resetTimer()
                    }){
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(selectedTab.theme.accentColor)
                            .frame(width: 20, height: 20, alignment: .leading)
                    }
                    .padding(.trailing, 20)
                }
                ZStack {
                    if pomodoroTimer.timerFired == false {
                        Text("\(formatTime(seconds: lengthInMinutes * 60))")
                            .font(.system(size: 50))
                            .foregroundStyle(selectedTab.theme.accentColor)
                            .padding()
                    } else {
                        Text("\(formatTime(seconds: pomodoroTimer.secondsRemaining))")
                            .foregroundStyle(selectedTab.theme.accentColor)
                            .font(.system(size: 50))
                            .padding()
                    }
                    ProgressBar(lengthInMinutes: $selectedTab.lengthInMinutes, secondsElapsed: $pomodoroTimer.secondsElapsed)
                        .padding()
                }
                VStack {
                    Button(action: {
                        isTrackingTime.toggle()
                        if pomodoroTimer.timerFired == false {
                            newTimerStarted = true
                        }
                        if isTrackingTime {
                            startCountdown()
                            
                            // stop all running live activities
                            for activity in Activity<TimerAttributes>.activities {
                                Task {
                                    await activity.end(nil, dismissalPolicy: .immediate)
                                }
                            }
                            
                            
                            endTime = Date.now
                            let attributes = TimerAttributes()
                            guard let endTime else { return }
                            let state = TimerAttributes.ContentState(endTime: endTime, secondsRemaining: pomodoroTimer.secondsRemaining, sessionName: selectedTab.name)
                            let content = ActivityContent(state: state, staleDate: nil)
                            activity = try? Activity.request(attributes: attributes, content: content, pushType: nil)
                            
                            
                        } else {
                            stopTimer()
                        }
                    }) {
                        Image(systemName: isTrackingTime ? "stop.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(selectedTab.theme.accentColor)
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            movingToBackground()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            movingToForeground()
        }
        .onChange(of: pomodoroTimer.shouldResetTimer){
            if pomodoroTimer.shouldResetTimer == true {
                resetTimer()
                pomodoroTimer.shouldResetTimer = false
            }
        }
        .onChange(of: pomodoroTimer.secondsRemaining){
            if pomodoroTimer.secondsRemaining == 0 && pomodoroTimer.timerFired == true{
                resetTimer()
            }
        }
    }
    private func stopTimer(){
        pomodoroTimer.stopCountdown()
        //print("timerFired: \(pomodoroTimer.timerFired)")

        let finalState = TimerAttributes.ContentState(endTime: Date().addingTimeInterval(Double(pomodoroTimer.secondsRemaining) + 1), secondsRemaining: pomodoroTimer.secondsRemaining, sessionName: selectedTab.name)
        Task {
            await activity?.end(ActivityContent(state: finalState, staleDate: .now), dismissalPolicy: ActivityUIDismissalPolicy.default)
        }
        self.endTime = nil
    }
    func resetTimer(){
        pomodoroTimer.reset(lengthInMinutes: lengthInMinutes)
        stopTimer()
        isTrackingTime = false
        //print("timerFired: \(pomodoroTimer.timerFired)")

    }
    private func startCountdown() {
        if pomodoroTimer.timerFired == false{
            pomodoroTimer.reset(lengthInMinutes: lengthInMinutes)
        }
        pomodoroTimer.startCountdown()
        //print("timerFired: \(pomodoroTimer.timerFired)")
    }
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    func movingToBackground() {
        print("Moving to the background")
        notificationDate = Date()
        //secondsElapsedCache = pomodoroTimer.secondsElapsed
        pomodoroTimer.stopCountdown()
    }
    func movingToForeground() {
        print("Moving to the foreground")
        if isTrackingTime == true {
            let deltaTime: Int = Int(Date().timeIntervalSince(notificationDate))
            pomodoroTimer.secondsElapsed += deltaTime
            pomodoroTimer.startCountdown()
        }
    }
       
}

#Preview {
    TimerCardView(tabs: .constant(TabDetails.defaultData), selectedTab: .constant(TabDetails.defaultData[0]), lengthInMinutes: .constant(20), pomodoroTimer: PomodoroTimer(), newTimerStarted: .constant(false))
}
