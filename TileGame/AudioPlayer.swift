//
//  AudioPlayer.swift
//  TileGame
//
//  Created by Chandrachudh K on 16/01/23.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    static let shared = AudioPlayer()
    
    private var themeTrackPlayer: AVAudioPlayer?
    
    private override init() {}
    
    func playThemeTrack() {
        guard let url = Bundle.main.url(forResource: "BelowFreezing", withExtension: "mp3") else { return }
        
        do {
            themeTrackPlayer = try AVAudioPlayer(contentsOf: url)
            themeTrackPlayer?.delegate = self
            themeTrackPlayer?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Audio Player delegate methiods
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player == themeTrackPlayer {
            themeTrackPlayer?.play()
        }
    }
    
}
