//
//  DetailEditView.swift
//  Pomodoro
//
//  Created by Thái Khang on 22/01/2024.
//

import SwiftUI

struct DetailEditView: View {
    @State private var editedPomodoroSeconds: Int = Tab.pomodoro.defaultSecondValue
        @State private var editedShortBreakSeconds: Int = Tab.shortBreak.defaultSecondValue
        @State private var editedLongBreakSeconds: Int = Tab.longBreak.defaultSecondValue

        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Edit Default Seconds")) {
                        Stepper(value: $editedPomodoroSeconds, in: 1...120) {
                            Text("Pomodoro Seconds: \(editedPomodoroSeconds)")
                        }

                        Stepper(value: $editedShortBreakSeconds, in: 1...120) {
                            Text("Short Break Seconds: \(editedShortBreakSeconds)")
                        }

                        Stepper(value: $editedLongBreakSeconds, in: 1...120) {
                            Text("Long Break Seconds: \(editedLongBreakSeconds)")
                        }
                    }

                    Section {
                        Button("Save") {
                            // Handle save action (update defaultSecondValue for all tabs)
                            //Tab.pomodoro.defaultSecondValue = editedPomodoroSeconds
                            //Tab.shortBreak.defaultSecondValue = editedShortBreakSeconds
                            //Tab.longBreak.defaultSecondValue = editedLongBreakSeconds

                            print("Saved default seconds")
                        }
                    }
                }
                .navigationTitle("Edit Default Seconds")
            }
        }
}

#Preview {
    DetailEditView()
}
