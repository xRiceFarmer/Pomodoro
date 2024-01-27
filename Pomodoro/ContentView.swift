import SwiftUI
struct ContentView: View {
    //@State private var selectedTab: TabDetails = TabDetails.defaultData[0]
    //@State var tabDetails: [TabDetails] = TabDetails.defaultData
    @State private var isPresentingEditView = false
    @Binding var tabs : [TabDetails]
    @State var selectedTab : TabDetails
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $selectedTab){
                    ForEach($tabs)  {$tab in
                        TimerCardView(selectedTab: $tab, secondsRemaining: tab.lengthInMinutes)
                            .tag(tab)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(maxHeight: .infinity)
            }
            CustomTabBar(selectedTab: $selectedTab, tabDetails: tabs)
            .navigationTitle("Pomodoro Timer")
            .toolbar{
                //Button(action:{}){Image(systemName: "plus")}
                Button("Edit"){
                    isPresentingEditView = true
                }
            }
            .sheet(isPresented: $isPresentingEditView){
                NavigationStack{
                    DetailEditView()
                }
            }
        }
        .onChange(of: scenePhase){
            if scenePhase == .inactive {saveAction()}
        }
    }
}

#Preview {
    ContentView(tabs: .constant(TabDetails.defaultData), selectedTab: TabDetails.defaultData[0], saveAction: {})
}

