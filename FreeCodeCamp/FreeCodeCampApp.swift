//
//  FreeCodeCampApp.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-07.
//

import SwiftUI
import SwiftData

@main
struct FreeCodeCampApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
