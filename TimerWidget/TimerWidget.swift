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
                }
            } compactLeading: {
                Text("Pom")
            } compactTrailing: {
                Text("CT")
            } minimal: {
                Text("M")
            }

        }
    }
}

struct TimerWidgetView: View {
    let context: ActivityViewContext<TimerAttributes>
    var body: some View {
        Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
            .font(.headline)
            .padding()
    }
}

