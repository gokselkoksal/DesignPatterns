//: [Previous](@previous)

import Foundation

protocol MediaPlayer {
    func play(file: String)
}

class MP3Player: MediaPlayer {
    func play(file: String) {
        print("Playing \(file).")
    }
}

class MP4Player: MediaPlayer {
    func play(file: String) {
        print("Playing \(file).")
    }
}

enum MediaType: String {
    case mp3
    case mp4
    case mkv
}

protocol AdvancedMediaPlayer {
    func play(file: String, type: MediaType)
}

class MediaPlayerAdapter: AdvancedMediaPlayer {
    
    private let mp3Player = MP3Player()
    private let mp4Player = MP4Player()
    
    func play(file: String, type: MediaType) {
        switch type {
        case .mp3:
            mp3Player.play(file: file)
        case .mp4:
            mp4Player.play(file: file)
        case .mkv:
            print("MKV format is not supported.")
        }
    }
}

let player: AdvancedMediaPlayer = MediaPlayerAdapter()
player.play(file: "song.mp3", type: .mp3)
player.play(file: "movie.mp4", type: .mp4)
player.play(file: "episode.mkv", type: .mkv)

//: [Next](@next)
