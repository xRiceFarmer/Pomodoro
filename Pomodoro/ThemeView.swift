//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Thái Khang on 10/01/2024.
//

import SwiftUI
struct ThemeView: View {
    let theme: Theme
    var body: some View {
    
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        
    }
}

#Preview {
    ThemeView(theme: .bubblegum)
}
