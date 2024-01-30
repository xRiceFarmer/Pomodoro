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
            ForEach(tabs.indices, id: \.self) {index in
                Section(header: Text(tabs[index].name)){
                    HStack{
                        Slider(value: $tabs[index].lengthInMinutesAsDoubles, in: 1...30, step: 1){
                            Text("Length")
                        }
                        .accessibilityValue("\(tabs[index].lengthInMinutes) minutes")
                        Spacer()
                        Text("\(tabs[index].lengthInMinutes) minutes")
                            .accessibilityHidden(true)
                    }
                }
            }
        }
    }
}

#Preview {
    DetailEditView(tabs: .constant(TabDetails.defaultData))
}
