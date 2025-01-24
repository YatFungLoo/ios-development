//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import Foundation

struct DailyScrum: Identifiable {
    let id: UUID
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    static var sampleData: [DailyScrum] =
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
        
        DailyScrum(
            title: "Test",
            attendees: ["Bond", "Morgen", "Mary"],
            lengthInMinutes: 20,
            theme: .bubblegum),
    ]
    
}

