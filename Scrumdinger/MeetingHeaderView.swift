//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 4/2/2025.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElasped: Int
    let secondsRemaining: Int
    let theme: Theme

    private var totalSeconds: Int {
        secondsElasped + secondsRemaining // single expression doesn't require return statement.
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }  // Base case check.
        return Double(secondsElasped) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }

    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elasped").font(.caption)
                    Label(
                        "\(secondsElasped)",
                        systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining").font(.caption)
                    Label(
                        "\(secondsRemaining)",
                        systemImage: "hourglass.bottomhalf.fill")
                }
                .labelStyle(.trailingIcon)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) mintues")
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElasped: 3, secondsRemaining: 9, theme: .orange)
            .previewLayout(.sizeThatFits)
    }
}
