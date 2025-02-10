//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 10/2/2025.
//

import SwiftUI

@MainActor  // marked for async load function.
class ScrumStore: ObservableObject {
    // Any view observing this property will re-render again when this value changes.
    @Published var scrums: [DailyScrum] = []
    /*
     Save data to user's Documents folder. Create has to be true for .documentationDirectory.
     .documentDirectory {Device_Folder}/Documents.
     .documentationDirectory {Device_Folder}/Library/Documentation/ which doesnt exist at app launch.
     */
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask,
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
        self.scrums = scrums
    }

    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value  // _ meaning return value is discarded.
    }
}
