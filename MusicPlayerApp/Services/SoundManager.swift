//
//  SoundManager.swift
//  MusicPlayerApp
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import Foundation
import AVFoundation
import AVFAudio

protocol SoundManagerProtocol {
    func playSound(url: String)
    func pause()
}

final class SoundManager: SoundManagerProtocol {
    var audioPlayer: AVPlayer?
    private var isPaused: Bool = true
    
    func playSound(url: String) {
        if let url = URL(string: url) {
            self.audioPlayer = AVPlayer(url: url)
            self.audioPlayer?.play()
        }
    }
    
    func pause() {
        if isPaused {
            self.audioPlayer?.play()
        } else {
            self.audioPlayer?.pause()
        }
        isPaused.toggle()
    }
}
