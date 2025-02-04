//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                ProgressView(value: 3, total: 9)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Second Elasped").font(.caption)
                        Label("300", systemImage: "hourglass.tophalf.fill")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Second Remaining").font(.caption)
                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .accessibilityValue("10 mintues")
                Circle().strokeBorder(lineWidth: 40)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding(20)
        .foregroundColor(scrum.theme.accentColor)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews : PreviewProvider {
    static var previews : some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
