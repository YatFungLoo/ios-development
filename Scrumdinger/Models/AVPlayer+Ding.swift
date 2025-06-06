/*
See LICENSE folder for this sample’s licensing information.
*/

import AVFoundation
import Foundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard
            let url = Bundle.main.url(forResource: "ding", withExtension: "wav")
        else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
