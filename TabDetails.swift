import Foundation
struct TabDetails {
    var name : String
    var theme : String
    var lengthInMinutes: Int
    
    init(name: String, theme: String, lengthInMinutes: Int) {
        self.name = name
        self.theme = theme
        self.lengthInMinutes = lengthInMinutes
    }
}
extension TabDetails{
    static let defaultData: [TabDetails] = [
        TabDetails(name: "Pomodoro", theme: ".blue", lengthInMinutes: 25),
        TabDetails(name: "Short Break", theme: ".red", lengthInMinutes: 5),
        TabDetails(name: "Long Break", theme: ".green", lengthInMinutes: 10)
    ]
}
