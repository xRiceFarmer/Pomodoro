
import SwiftUI
import ActivityKit
import Foundation

struct TimerCardView: View {
    @Binding var selectedTab: TabDetails
    @State var secondsRemaining: Int
    @State private var isTrackingTime: Bool = false
    @State private var endTime: Date? = nil
    @State private var activity: Activity<TimerAttributes>? = nil
    @State private var timer: Timer? = nil
    @State private var isPaused = false
    
  
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(selectedTab.theme.mainColor)
            VStack {
                Text("Countdown Timer: \(secondsRemaining) seconds")
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
                                let state = TimerAttributes.ContentState(endTime: endTime, secondsRemaining: secondsRemaining)
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
        guard let endTime else { return }
        let finalState = TimerAttributes.ContentState(endTime: Date().addingTimeInterval(Double(secondsRemaining) + 1), secondsRemaining: secondsRemaining)
        Task {
            await activity?.end(ActivityContent(state: finalState, staleDate: .now), dismissalPolicy: ActivityUIDismissalPolicy.default)
        }
        self.endTime = nil
    }
    private func resetTimer(){
        secondsRemaining = selectedTab.lengthInMinutes
        isTrackingTime = false
        let finalState = TimerAttributes.ContentState(endTime: Date().addingTimeInterval(Double(secondsRemaining) + 1), secondsRemaining: secondsRemaining)
        Task {
            await activity?.end(ActivityContent(state: finalState, staleDate: .now), dismissalPolicy: ActivityUIDismissalPolicy.default)
        }
    }
    private func startCountdown() {
        // Invalidate the existing timer if any
        timer?.invalidate()

        // Create and start a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if isTrackingTime {
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                } else {
                    // Timer reached zero, perform additional actions if needed
                    timer?.invalidate()
                }
            }
        }
    }
}


#Preview {
    TimerCardView(selectedTab: .constant(TabDetails.defaultData[0]), secondsRemaining: 20)
}
