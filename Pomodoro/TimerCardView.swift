
import SwiftUI
import ActivityKit
import Foundation

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
                    Text.init(timerInterval:  Date.now...Date(timeInterval: 20, since: .now), pauseTime: endTime)
                        .font(.headline)
                        .foregroundStyle(.bar)
                }
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                    .overlay {
                        Button(action: {
                            //let components = DateComponents(second: 10)
                            //let futureDate = Calendar.current.date(byAdding: components, to: Date())!
                            isTrackingTime.toggle()
                            
                            if isTrackingTime {
                                for activity in Activity<TimerAttributes>.activities {
                                    Task {
                                        await activity.end(nil, dismissalPolicy: .immediate)
                                    }
                                }
                                
                                //endTime = Date().addingTimeInterval(20)
                                endTime = Date.now
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
