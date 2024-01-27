import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabDetails
    @State var tabDetails: [TabDetails]

    
    var body: some View {
        VStack {
            HStack {
                ForEach(tabDetails) { tab in
                    Spacer()
                    Text(tab.name)
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
        CustomTabBar(selectedTab: .constant(TabDetails.defaultData[0]), tabDetails: TabDetails.defaultData)
    }
}
