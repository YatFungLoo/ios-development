//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import Foundation

struct DailyScrum {
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(
            title: "Design",
            attendees: ["Dexter", "Baxter", "Lexter"],
            lengthInMinutes: 10,
            theme: .orange),
        
        DailyScrum(
            title: "Develop",
            attendees: ["John", "Lewis", "Mary"],
            lengthInMinutes: 35,
            theme: .teal),
    ]
    
}

