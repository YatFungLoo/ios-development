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
    @State private var errorWrapper: ErrorWrapper?  // Default value of an optional is nil. (Note: use ":")

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {  // Array binding syntex
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(
                            error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(
                        error: error,
                        guidance:
                            "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
