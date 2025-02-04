//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 4/2/2025.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElasped: Int
    let minutesElasped: Int

    private var totalSeconds: Int {
        secondsElasped + minutesElasped // single expression doesn't require return statement.
    }
    private var progress: Double {
        guard totalSeconds < 0 else { return 1 } // Base case check.
        return Double(secondsElasped) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsElasped / 60
    }
    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Text("Second Elasped").font(.caption)
                    Label(
                        "\(secondsElasped)",
                        systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Second Remaining").font(.caption)
                    Label(
                        "\(minutesElasped)",
                        systemImage: "hourglass.bottomhalf.fill")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) mintues")
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElasped: 3, minutesElasped: 9)
            .previewLayout(.sizeThatFits)
    }
}
