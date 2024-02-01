//
//  TimerWidgetBundle.swift
//  TimerWidget
//
//  Created by Thái Khang on 19/01/2024.
//

import WidgetKit
import SwiftUI

@main
struct TimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        if #available(iOS 17.0, *){
            TimerWidget()
        }
    }
}
