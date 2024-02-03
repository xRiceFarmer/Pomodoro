import SwiftUI
struct ContentView: View {
    //@State private var selectedTab: TabDetails = TabDetails.defaultData[0]
    //@State var tabDetails: [TabDetails] = TabDetails.defaultData
    @State private var editingTab = TabDetails.defaultData
    @State private var isPresentingEditView = false
    @Binding var tabs : [TabDetails]
    @State var selectedTabIndex : Int = 0
    
    @StateObject var pomodoroSessionTimer = PomodoroTimer()
    @StateObject var shortBreakSessionTimer = PomodoroTimer()
    @StateObject var longBreakSessionTimer = PomodoroTimer()

    @State var newPomodoroTimerStarted = false
    @State var newShortBreakTimerStarted = false
    @State var newLongBreakTimerStarted = false



    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $selectedTabIndex){
                    TimerCardView(tabs: $tabs, selectedTab: $tabs[0], lengthInMinutes: $tabs[0].lengthInMinutes, pomodoroTimer: pomodoroSessionTimer, newTimerStarted: $newPomodoroTimerStarted)
                        .tag(0)
                        .padding()
                    TimerCardView(tabs: $tabs, selectedTab: $tabs[1], lengthInMinutes: $tabs[1].lengthInMinutes, pomodoroTimer: shortBreakSessionTimer, newTimerStarted: $newShortBreakTimerStarted)
                        .tag(1)
                        .padding()
                    TimerCardView(tabs: $tabs, selectedTab: $tabs[2], lengthInMinutes: $tabs[2].lengthInMinutes, pomodoroTimer: longBreakSessionTimer, newTimerStarted: $newLongBreakTimerStarted)
                        .tag(2)
                        .padding()
                        
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .frame(maxHeight: .infinity)
            }
            CustomTabBar(selectedTabIndex: $selectedTabIndex, tabDetails: $tabs)
            .navigationTitle("Pomodoro Timer")
            .toolbar{
                //Button(action:{}){Image(systemName: "plus")}
                Button("Edit"){
                    isPresentingEditView = true
                    editingTab = tabs
                }
            }
            .sheet(isPresented: $isPresentingEditView){
                NavigationStack{
                    DetailEditView(tabs: $editingTab)
                        .navigationTitle(Text("Duration and Themes"))
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel"){
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done"){
                                   /**
                                    if tabs[0].lengthInMinutes != editingTab[0].lengthInMinutes || tabs[1].lengthInMinutes != editingTab[1].lengthInMinutes || tabs[2].lengthInMinutes != editingTab[2].lengthInMinutes {
                                        pomodoroSessionTimer.shouldResetTimer = true
                                        shortBreakSessionTimer.shouldResetTimer = true
                                        longBreakSessionTimer.shouldResetTimer = true
                                    }  **/
                                    
                                    if tabs[0].lengthInMinutes != editingTab[0].lengthInMinutes {
                                        pomodoroSessionTimer.shouldResetTimer = true
                                    }
                                    if tabs[1].lengthInMinutes != editingTab[1].lengthInMinutes {
                                        shortBreakSessionTimer.shouldResetTimer = true
                                    }
                                    if tabs[2].lengthInMinutes != editingTab[2].lengthInMinutes {
                                        longBreakSessionTimer.shouldResetTimer = true
                                    }
                                    
                                    isPresentingEditView = false
                                    tabs = editingTab
                                    
                                }
                            }
                        }
                }
            }
            .onChange(of: newPomodoroTimerStarted){
                if newPomodoroTimerStarted == true {
                    shortBreakSessionTimer.shouldResetTimer = true
                    longBreakSessionTimer.shouldResetTimer = true
                    newPomodoroTimerStarted = false
                }
            }
            .onChange(of: newShortBreakTimerStarted){
                if newShortBreakTimerStarted == true {
                    pomodoroSessionTimer.shouldResetTimer = true
                    longBreakSessionTimer.shouldResetTimer = true
                    newShortBreakTimerStarted = false
                }
            }
            .onChange(of: newLongBreakTimerStarted){
                if newLongBreakTimerStarted == true {
                    pomodoroSessionTimer.shouldResetTimer = true
                    shortBreakSessionTimer.shouldResetTimer = true
                    newLongBreakTimerStarted = false
                }
            }
        }
        .onChange(of: scenePhase){
            if scenePhase == .inactive {saveAction()}
        }
    }
}

#Preview {
    ContentView(tabs: .constant(TabDetails.defaultData),  saveAction: {})
}

