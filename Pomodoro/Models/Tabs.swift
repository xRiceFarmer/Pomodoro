import SwiftUI
enum Tab: String, CaseIterable {
    case pomodoro
    case shortBreak
    case longBreak
    
    var tabDescription: String {
        switch self {
        case .pomodoro: return("Pomodoro")
        case .shortBreak: return("Short Break")
        case .longBreak: return("Long Break")
        }
    }
    var mainColor: Color {
        switch self {
        case .pomodoro:
            return .blue
        case .shortBreak:
            return .red
        case .longBreak:
            return .yellow
        }
    }
    var defaultSecondValue : Int {
        switch self {
        case .pomodoro: return(10)
        case .shortBreak: return(20)
        case .longBreak: return(30)
        }
    }
}
