//
//  ScrumTimerView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 13/2/2025.
//

import SwiftUI

struct ScrumTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme

    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text("\(currentSpeaker)")
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted,
                        let index = speakers.firstIndex(where: {
                            $0.id == speaker.id
                        })
                    {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct ScrumTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {
        [
            ScrumTimer.Speaker(name: "Felix", isCompleted: true),
            ScrumTimer.Speaker(name: "Dexter", isCompleted: false),
        ]
    }

    static var previews: some View {
        ScrumTimerView(
            speakers: speakers, theme: DailyScrum.sampleData[0].theme)
    }
}
