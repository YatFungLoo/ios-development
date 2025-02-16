//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 23/1/2025.
//

import AVFoundation
import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    fileprivate func startScrum() {
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }

    fileprivate func stopScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(
            attendees: scrum.attendees,
            transcript: speechRecognizer.transcript
        )
        scrum.history.insert(newHistory, at: 0)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElasped: scrumTimer.secondsElasped,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme)
                ScrumTimerView(
                    speakers: scrumTimer.speakers,
                    isRecording: isRecording,
                    theme: scrum.theme)
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding(15)
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
