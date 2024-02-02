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
                DynamicIslandExpandedRegion(.trailing){
                    Text(context.state.sessionName)
                }
            } compactLeading: {
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
            } compactTrailing: {
                Text(context.state.sessionName)
            } minimal: {
                ProgressView(
                    timerInterval: Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now),
                    countsDown: true
                    //label: { EmptyView() },
                    //currentValueLabel: { EmptyView() }
                )
                .progressViewStyle(.circular)
                .tint(.pink)
            }
        }
    }
}

struct TimerWidgetView: View {
    let context: ActivityViewContext<TimerAttributes>
    var body: some View {
        VStack{
            HStack{
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                    .font(.headline)
                    .padding()
                Text(context.state.sessionName)
                    .padding()
            }
            ProgressView(
                timerInterval: Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now),
                countsDown: true
                //label: { EmptyView() },
                //currentValueLabel: { EmptyView() }
            )
            .progressViewStyle(.automatic)
            .tint(.pink)
        }
        
        

    }
}

