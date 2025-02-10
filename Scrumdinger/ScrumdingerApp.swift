//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    // StateObject creates a single observable object for each instance of the structe that declares it.
    @StateObject private var store = ScrumStore()

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {  // Array binding syntex
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
