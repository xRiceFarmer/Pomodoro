
import SwiftUI
import ActivityKit
import Foundation

struct TimerCardView: View {
    @Binding var selectedTab: TabDetails
    @Binding var lengthInMinutes: Int
    @State private var isTrackingTime: Bool = false
    @State private var endTime: Date? = nil
    @State private var activity: Activity<TimerAttributes>? = nil
    @State private var timer: Timer? = nil
    @State private var isPaused = false
    @StateObject var pomodoroTimer = PomodoroTimer()
  
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(selectedTab.theme.mainColor)
            VStack {
                Text("Countdown Timer: \(pomodoroTimer.secondsRemaining) seconds")
                    .padding()
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                    .overlay {
                        Button(action: {
                            isTrackingTime.toggle()
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
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                Button(action:{
                    resetTimer()
                }){
                    Text("Reset")
                        .foregroundStyle(.white)
                        .padding(.top)
                }
                .padding()
            }
        }
        .onDisappear(){
            isTrackingTime = false
            stopTimer()
        }
    }
    private func stopTimer(){
        pomodoroTimer.stopCountdown()
        let finalState = TimerAttributes.ContentState(endTime: Date().addingTimeInterval(Double(pomodoroTimer.secondsRemaining) + 1), secondsRemaining: pomodoroTimer.secondsRemaining, sessionName: selectedTab.name)
        Task {
            await activity?.end(ActivityContent(state: finalState, staleDate: .now), dismissalPolicy: ActivityUIDismissalPolicy.default)
        }
        self.endTime = nil
    }
    private func resetTimer(){
        pomodoroTimer.reset(lengthInMinutes: lengthInMinutes)
    }
    private func startCountdown() {
        pomodoroTimer.reset(lengthInMinutes: lengthInMinutes)
        pomodoroTimer.startCountdown()
    }
}


#Preview {
    TimerCardView(selectedTab: .constant(TabDetails.defaultData[0]), lengthInMinutes: .constant(20))
}
