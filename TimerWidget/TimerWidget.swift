import ActivityKit
import WidgetKit
import SwiftUI


struct TimerWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading){
                    Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                        .fontWeight(.bold)
                }
                DynamicIslandExpandedRegion(.trailing){
                    Text(context.state.sessionName)
                        .fontWeight(.bold)
                }
            } compactLeading: {
                Text(context.state.sessionName)
            } compactTrailing: {
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
            } minimal: {
           
            }
        }
    }
}

struct TimerWidgetView: View {
    let context: ActivityViewContext<TimerAttributes>
    var body: some View {
            HStack{
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                    .font(.headline)
                    .padding()
                Text(context.state.sessionName)
                    .padding()
            }
    }
}

