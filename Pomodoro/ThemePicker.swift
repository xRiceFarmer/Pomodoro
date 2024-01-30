//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Thái Khang on 10/01/2024.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Theme", selection: $selection){
            ForEach(Theme.allCases){ theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    ThemePicker(selection: .constant(.periwinkle))
}
