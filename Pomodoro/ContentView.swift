import SwiftUI
import ActivityKit
struct ContentView: View {
    @State private var selectedTab: Tab = .pomodoro
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $selectedTab){
                    ForEach(Tab.allCases, id: \.rawValue){ tab in
                        TimerCardView(selectedTab: tab, secondsRemaining: tab.defaultSecondValue)
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
                //Button(action:{}){Image(systemName: "plus")}
                Button(action:{}){Text("Edit")}

            }
        }
    }
}

#Preview {
    ContentView()
}

