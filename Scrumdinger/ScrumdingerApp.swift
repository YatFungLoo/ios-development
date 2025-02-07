//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)  // Array binding syntex
        }
    }
}
