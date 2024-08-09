//
//  SoundManager.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 9.08.24.
//

import AVFoundation

enum SoundType: String {
    case coins = "coins"
    case pair = "pair"
    case notPair = "notPair"
    case win = "win"
}

struct SoundManager {
    
    static var isEnabled = true

    private static var audioPlayer: AVAudioPlayer?

    static func playSound(type: SoundType) {
        if isEnabled {
            guard let url = Bundle.main.url(forResource: type.rawValue, withExtension: "wav")
            else { return }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {}
        }
    }
}
