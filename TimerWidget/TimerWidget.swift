import ActivityKit
import WidgetKit
import SwiftUI


struct TimerWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                /**DynamicIslandExpandedRegion(.center){
                    Image("pomodoroIcon")
                        .frame(maxWidth: .minimum(70, 70), alignment: .leading)
                 }**/
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
                    VStack(alignment: .center){
                        
                        Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .frame(maxWidth: .minimum(60, 60), alignment: .center)
                            .padding(.trailing)
                        Image("pomodoroIcon")
                            .frame(maxWidth: .minimum(20, 20), alignment: .trailing)
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
        HStack(alignment: .center){
                Image("pomodoroIcon")
                    .frame(maxWidth: .minimum(50, 50), alignment: .center)
                    .padding(.leading)
                Text(context.state.sessionName)
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundStyle(.gray)

            VStack{
                Text.init(timerInterval:  Date.now...Date(timeInterval: Double(context.state.secondsRemaining), since: .now), pauseTime: context.state.endTime)
                .font(.system(size: 30, weight: .bold, design: .default))
                .padding(.horizontal, 40)
                //.frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.trailing)
            }
            .frame(alignment: .trailing)
            Spacer()
        }
    }
}

