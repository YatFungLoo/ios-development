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
                MeetingHeaderView(secondsElasped: 3, minutesElasped: 9, theme: scrum.theme)
                Circle().strokeBorder(lineWidth: 40)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
                .padding(15)
            }
        }
        .padding(15)
        .foregroundColor(scrum.theme.accentColor)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews : PreviewProvider {
    static var previews : some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
