//
//  MusicWidget.swift
//  LifeBoardWidgets
//
//  Music widget implementation
//  Displays now playing information
//

import Foundation
import MediaPlayer
import SwiftUI

/// Music widget that displays now playing information
public struct MusicWidget: WidgetProtocol {
    
    public let id: String
    public let name: String = "Music"
    public let type: String = "music"
    public var position: Int
    public var size: WidgetSize
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        position: Int = 0,
        size: WidgetSize = .medium
    ) {
        self.id = id
        self.position = position
        self.size = size
    }
    
    // MARK: - WidgetProtocol
    
    public func fetchData() async throws -> WidgetData {
        // Check if music is playing
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        let nowPlaying = musicPlayer.nowPlayingItem
        
        if let item = nowPlaying {
            let data: [String: AnyCodable] = [
                "title": AnyCodable(item.title ?? "Unknown"),
                "artist": AnyCodable(item.artist ?? "Unknown Artist"),
                "album": AnyCodable(item.albumTitle ?? ""),
                "isPlaying": AnyCodable(musicPlayer.playbackState == .playing),
                "playbackTime": AnyCodable(musicPlayer.currentPlaybackTime),
                "duration": AnyCodable(item.playbackDuration)
            ]
            return WidgetData(content: data)
        } else {
            // No music playing
            return WidgetData(content: [
                "isPlaying": AnyCodable(false)
            ])
        }
    }
    
    @ViewBuilder
    public func view() -> AnyView {
        AnyView(MusicWidgetContainer())
    }
    
    public mutating func resize(to newSize: WidgetSize) {
        self.size = newSize
    }
}

