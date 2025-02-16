//
//  History.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 8/2/2025.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var transcript: String?

    init(
        id: UUID = UUID(), date: Date = Date(),
        attendees: [DailyScrum.Attendee], transcript: String? = nil
    ) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}

extension History {
    static var sampleHistory: [History] =
        [
            History(
                date: Date.now,
                attendees: DailyScrum.sampleData[0].attendees,
                transcript: "This is sample data one."
            ),
            
            History(
                date: Date.now,
                attendees: DailyScrum.sampleData[1].attendees
            ),
        ]
}
