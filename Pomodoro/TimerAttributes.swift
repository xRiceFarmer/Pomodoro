import ActivityKit
import Foundation
import SwiftUI
struct TimerAttributes: ActivityAttributes{
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var endTime: Date
    }
}
