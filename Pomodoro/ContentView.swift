import SwiftUI
struct ContentView: View {
    //@State private var selectedTab: TabDetails = TabDetails.defaultData[0]
    //@State var tabDetails: [TabDetails] = TabDetails.defaultData
    @State private var editingTab = TabDetails.defaultData
    @State private var isPresentingEditView = false
    @Binding var tabs : [TabDetails]
    @State var selectedTabIndex : Int = 0
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationStack {
            VStack{
                TabView(selection: $selectedTabIndex){
                    ForEach(tabs.indices, id: \.self)  {index in
                        TimerCardView(selectedTab: $tabs[index], lengthInMinutes: $tabs[index].lengthInMinutes)
                            .tag(index)
                            .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .frame(maxHeight: .infinity)
            }
            CustomTabBar(selectedTabIndex: $selectedTabIndex, tabDetails: tabs)
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
                                    isPresentingEditView = false
                                    tabs = editingTab
                                }
                            }
                        }
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

