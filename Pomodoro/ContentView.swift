//
//  ContentView.swift
//  Pomodoro
//
//  Created by Thái Khang on 15/01/2024.
//

import SwiftUI
import ActivityKit
struct ContentView: View {
    @State private var selectedTab: Tab = .pomodoro
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $selectedTab){
                    ForEach(Tab.allCases, id: \.rawValue){ tab in
                        TimerCardView(selectecTab: tab)
                            .tag(tab)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(maxHeight: .infinity)
            }
            CustomTabBar(selectedTab: $selectedTab)
            .navigationTitle("Pomodoro Timer")
            .toolbar{
                Button(action:{}){Image(systemName: "plus")}
                Button(action:{}){Text("Reset")}

            }
        }
    }
}

#Preview {
    ContentView()
}

