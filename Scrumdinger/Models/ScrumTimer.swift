//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 5/2/2025.
//

import Foundation

@MainActor
final class ScrumTimer: ObservableObject {
    // Current speaker struct
    struct Speaker: Identifiable {
        let id = UUID()
        let name: String
        var isCompleted: Bool
    }

    // @Published var changes within an @ObservableObject will trigger update to SwiftUI object observers.
    @Published var activeSpeaker = ""
    @Published var secondElasped = 0
    @Published var secondsRemaining = 0

    private(set) var speakers: [Speaker] = []
    private(set) var lengthInMinutes: Int

    var speakerCnagedAction: (() -> Void)?
    private weak var timer: Timer?

    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?

    /**
     - Parameters:
     - lengthInMinutes jelloThe meeting lengths
     -  attendees: A list of attendees for the meeting.
     */
    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }

    func startScum() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
        {
            [weak self] timer in
            self?.update()
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }

    func stopScrume() {
        timer?.invalidate()
        timerStopped = true
    }

    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }

    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else { return }
        speakerIndex = index
        activeSpeaker = speakerText

        secondElasped = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondElasped
        startDate = Date()
    }

    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else { return }
            let secondsElapsed = Int(
                Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondElasped =
                secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            guard secondsElapsed <= secondsPerSpeaker else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsRemaining, 0)

            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerCnagedAction?()
            }
        }
    }

    /**
     Reset the timer with a new meeting length and new attendees.

     - Parameters:
     - lengthInMinutes: The meeting length.
     - attendees: The name of each attendee.
     */
    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}

extension [DailyScrum.Attendee] {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
        } else {
            return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
        }
    }
}
