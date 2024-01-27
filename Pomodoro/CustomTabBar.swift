import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTabIndex: Int
    @State var tabDetails: [TabDetails]

    
    var body: some View {
        VStack {
            HStack {
                ForEach(tabDetails.indices, id: \.self) { index in
                    Spacer()
                    Text(tabDetails[index].name)
                        .font(.system(size: 16, weight: tabDetails[selectedTabIndex] == tabDetails[index] ? .bold : .regular)) // Use bold font when selected
                        .foregroundColor(tabDetails[selectedTabIndex] == tabDetails[index] ? .blue : .black)
                        .onTapGesture {
                            selectedTabIndex = index
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
        CustomTabBar(selectedTabIndex: .constant(0), tabDetails: TabDetails.defaultData)
    }
}
