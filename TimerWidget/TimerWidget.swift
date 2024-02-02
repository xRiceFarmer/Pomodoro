import ActivityKit
import WidgetKit
import SwiftUI


struct TimerWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerWidgetView(context: context)
                .activityBackgroundTint(Color.white.opacity(0.25))

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading){
                    VStack{
                        ProgressView(
                            timerInterval: Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now),
                            countsDown: true,
                            label: { EmptyView() },
                            currentValueLabel: {
                                if context.state.sessionName == "Pomodoro"{
                                    Text("PM")
                                        .frame(maxWidth: .minimum(20, 20))
                                }
                                if context.state.sessionName == "Short Break"{
                                    Text("SB")
                                        .frame(maxWidth: .minimum(20, 20))

                                }
                                if context.state.sessionName == "Long Break"{
                                    Text("LB")
                                        .frame(maxWidth: .minimum(20, 20))

                                }
                            }
                        )
                        .progressViewStyle(.circular)
                        .tint(.green)
                        .frame(maxWidth: .minimum(50, 50), alignment: .trailing)
                    }
                    
                }
                DynamicIslandExpandedRegion(.trailing){
                    VStack{
                        
                        Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                            .fontWeight(.bold)
                            .frame(maxWidth: .minimum(50, 50), alignment: .center)
                    }
                       
                }
            } compactLeading: {
                ProgressView(
                    timerInterval: Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now),
                    countsDown: true,
                    label: { EmptyView() },
                    currentValueLabel: {
                        if context.state.sessionName == "Pomodoro"{
                            Text("PM")
                                .frame(maxWidth: .minimum(20, 20))
                        }
                        if context.state.sessionName == "Short Break"{
                            Text("SB")
                                .frame(maxWidth: .minimum(20, 20))

                        }
                        if context.state.sessionName == "Long Break"{
                            Text("LB")
                                .frame(maxWidth: .minimum(20, 20))

                        }
                    }
                )
                .progressViewStyle(.circular)
                .tint(.green)
                .frame(maxWidth: .minimum(50, 50), alignment: .trailing)
            } compactTrailing: {
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                    .frame(maxWidth: .minimum(50, 50), alignment: .leading)
            } minimal: {
           
            }
        }
    }
}

struct TimerWidgetView: View {
    let context: ActivityViewContext<TimerAttributes>
    var body: some View {
            HStack{
                Text(context.state.sessionName)
                    .frame(alignment: .leading)
                    .padding()
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                    .font(.headline)
                    .frame(alignment: .trailing)
                    .padding()
                
            }
    }
}

