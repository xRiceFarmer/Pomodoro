import Foundation
import SwiftUI
struct TabDetails: Codable, Identifiable, Hashable {
    let id: UUID
    var name : String
    var theme : Theme
    var lengthInMinutesAsDoubles: Double{
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var lengthInMinutes: Int
    
    init(id: UUID = UUID(), name: String, theme: Theme, lengthInMinutes: Int) {
        self.id = id
        self.name = name
        self.theme = theme
        self.lengthInMinutes = lengthInMinutes
    }
}
extension TabDetails{
    static let defaultData: [TabDetails] = [
        TabDetails(name: "Pomodoro", theme: .buttercup, lengthInMinutes: 25),
        TabDetails(name: "Short Break", theme: .seafoam, lengthInMinutes: 5),
        TabDetails(name: "Long Break", theme: .lavender, lengthInMinutes: 10)
    ]
}
