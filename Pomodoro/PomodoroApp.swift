//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Thái Khang on 15/01/2024.
//

import SwiftUI

@main
struct PomodoroApp: App {
    @StateObject private var store = TabStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            ContentView(tabs: $store.tabs, selectedTab: store.tabs[0]){
                Task{
                    do {
                        try await store.save(tabs: store.tabs)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later")
                    }
                }
            }
            .task{
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Pomodoro will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper){
                store.tabs = TabDetails.defaultData
            } content: {wrapper in
                    ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
