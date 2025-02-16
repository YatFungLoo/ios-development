//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 16/2/2025.
//

import SwiftUI

struct HistoryView: View {
    let history: History

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let trans = history.transcript {
                    Text("Transcripts")
                        .font(.headline)
                        .padding(.top)
                    Text(trans)
                } else {
                    Text("No transcriptions.")
                        .font(.headline)
                        .padding(.top)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

#Preview {
    HistoryView(history: History.sampleHistory[0])
}
