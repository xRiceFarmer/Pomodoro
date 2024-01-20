import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Text(tab.tabDescription)
                        .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular)) // Use bold font when selected
                        .foregroundColor(selectedTab == tab ? .blue : .black)
                        .onTapGesture {
                            selectedTab = tab
                        }
                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: 60)
        .background(.thinMaterial)
        .cornerRadius(16)
        .padding()
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.pomodoro))
    }
}
