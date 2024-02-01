//
//  DetailEditView.swift
//  Pomodoro
//
//  Created by Thái Khang on 22/01/2024.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var tabs: [TabDetails]
    //@State private var editedPomodoroSeconds: Int = Tab.pomodoro.defaultSecondValue
       // @State private var editedShortBreakSeconds: Int = Tab.shortBreak.defaultSecondValue
        //@State private var editedLongBreakSeconds: Int = Tab.longBreak.defaultSecondValue

    var body: some View {
        Form {
            Section(header: Text(tabs[0].name)){
                VStack {
                    HStack{
                        Slider(value: $tabs[0].lengthInMinutesAsDoubles, in: 1...60, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(tabs[0].lengthInMinutes) minutes")
                        Spacer()
                        Text("\(tabs[0].lengthInMinutes) minutes")
                            .accessibilityHidden(true)
                    }
                    ThemePicker(selection: $tabs[0].theme)
                }
            }
            Section(header: Text(tabs[1].name)){
                VStack {
                    HStack{
                        Slider(value: $tabs[1].lengthInMinutesAsDoubles, in: 1...60, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(tabs[1].lengthInMinutes) minutes")
                        Spacer()
                        Text("\(tabs[1].lengthInMinutes) minutes")
                            .accessibilityHidden(true)
                    }
                    ThemePicker(selection: $tabs[1].theme)
                }
            }
            Section(header: Text(tabs[2].name)){
                VStack {
                    HStack{
                        Slider(value: $tabs[2].lengthInMinutesAsDoubles, in: 1...60, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(tabs[2].lengthInMinutes) minutes")
                        Spacer()
                        Text("\(tabs[2].lengthInMinutes) minutes")
                            .accessibilityHidden(true)
                    }
                    ThemePicker(selection: $tabs[2].theme)
                }
            }
        }
    }
}

#Preview {
    DetailEditView(tabs: .constant(TabDetails.defaultData))
}
