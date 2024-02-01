import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTabIndex: Int
    @Binding var tabDetails: [TabDetails]

    
    var body: some View {
        VStack {
            HStack {
                ForEach(tabDetails.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring()){
                            selectedTabIndex = index
                        }
                    }){
                        Text(tabDetails[index].name)
                            .foregroundColor(tabDetails[selectedTabIndex] == tabDetails[index] ? tabDetails[selectedTabIndex].theme.accentColor : .gray)
                            .frame(width: (UIScreen.main.bounds.width - 50) / 3)
                            .padding(.vertical, 10)
                            .font(.caption)
                    }
                    .background(tabDetails[selectedTabIndex] == tabDetails[index] ? tabDetails[selectedTabIndex].theme.mainColor :.clear)
                    .clipShape(Capsule())
                }
            }
        }
        .background(.thinMaterial)
        .clipShape(Capsule())
        .padding(.top, 25)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTabIndex: .constant(0), tabDetails: .constant(TabDetails.defaultData))
    }
}
