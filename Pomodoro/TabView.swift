import SwiftUI

struct CardTabView: View {
    var body: some View {
        NavigationView {
            TabView {
                CardView(title: "Card 1", color: .red)
                                .tag(0)
                                .tabItem {
                                    Label("Card 1", systemImage: "1.circle")
                                }

                CardView(title: "Card 2", color: .blue)
                    .tag(1)
                    .tabItem {
                        Label("Card 2", systemImage: "2.circle")
                    }

                CardView(title: "Card 3", color: .green)
                    .tag(2)
                    .tabItem {
                        Label("Card 3", systemImage: "3.circle")
                    }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .navigationTitle("Swipeable Cards")
        }
    }
}

struct CardView: View {
    let title: String
    let color: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 300, height: 200)

            Text(title)
                .foregroundColor(.white)
                .font(.title)
        }
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardTabView()
    }
}

