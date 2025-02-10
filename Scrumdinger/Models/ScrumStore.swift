//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 10/2/2025.
//

import SwiftUI

@MainActor  // marked for async load function.
class ScrumStore: ObservableObject {
    @Published var scrum: [DailyScrum] = []  // Any view observing this property will re-render again when this value changes.

    // Save data to user's Documents folder.
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentationDirectory, in: .userDomainMask,
            appropriateFor: nil, create: false
        )
        .appendingPathComponent("scrums.data")
    }

    // async comes before throws
    func load() async throws {
        let task = Task<[DailyScrum], Error> {
            let fileURL = try Self.fileURL()
            // file may not exist, but try anyway, return empty array if that is the case.
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            // If JSONDecoder throws an error, it will propergate when you try to access the value.
            let dailyScrums = try JSONDecoder().decode(
                [DailyScrum].self, from: data)
            return dailyScrums  // return the decoded data.
        }
        let scrums = try await task.value
        self.scrum = scrums
    }

    func save(scrum: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrum)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value // _ meaning return value is discarded.
    }
}
