//
//  MusicWidgetView.swift
//  LifeBoardWidgets
//
//  Music widget SwiftUI view
//  Displays now playing with programmatic design
//

import SwiftUI
import MediaPlayer

/// Music widget view
/// Displays now playing information with programmatic design
public struct MusicWidgetView: View {
    
    let nowPlaying: MPMediaItem?
    let isPlaying: Bool
    let playbackTime: TimeInterval
    let duration: TimeInterval
    
    public init(
        nowPlaying: MPMediaItem?,
        isPlaying: Bool,
        playbackTime: TimeInterval,
        duration: TimeInterval
    ) {
        self.nowPlaying = nowPlaying
        self.isPlaying = isPlaying
        self.playbackTime = playbackTime
        self.duration = duration
    }
    
    public var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [
                    Color.pink.opacity(0.2),
                    Color.purple.opacity(0.4)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .leading, spacing: 0) {
                // Top section
                HStack {
                    // Icon badge
                    RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.small)
                        .fill(DesignSystem.Colors.glass20)
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 24))
                                .foregroundColor(DesignSystem.Colors.textPrimary)
                        )
                    
                    Spacer()
                    
                    // Status indicators
                    HStack(spacing: DesignSystem.Spacing.compact) {
                        Circle()
                            .fill(isPlaying ? Color.green : DesignSystem.Colors.glass20)
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(DesignSystem.Colors.glass20)
                            .frame(width: 8, height: 8)
                    }
                }
                
                Spacer()
                
                // Track information
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.compact / 2) {
                    Text(nowPlaying?.title ?? "No Music Playing")
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .lineLimit(1)
                    
                    Text(artistAlbum)
                        .font(DesignSystem.Typography.secondary)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                        .lineLimit(1)
                }
                
                // Progress bar
                if duration > 0 {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(DesignSystem.Colors.glass20)
                                .frame(height: 1)
                            
                            // Progress
                            RoundedRectangle(cornerRadius: 0.5)
                                .fill(DesignSystem.Colors.textPrimary)
                                .frame(
                                    width: geometry.size.width * CGFloat(playbackTime / duration),
                                    height: 1
                                )
                        }
                    }
                    .frame(height: 1)
                    
                    // Time display
                    HStack {
                        Spacer()
                        Text(timeString(from: playbackTime))
                            .font(DesignSystem.Typography.metadata)
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                    }
                }
            }
            .padding(DesignSystem.Spacing.large)
        }
    }
    
    // MARK: - Private Helpers
    
    private var artistAlbum: String {
        guard let item = nowPlaying else {
            return "Select music to play"
        }
        let artist = item.artist ?? "Unknown Artist"
        let album = item.albumTitle ?? ""
        return album.isEmpty ? artist : "\(artist) • \(album)"
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Music Widget Container

struct MusicWidgetContainer: View {
    @State private var nowPlaying: MPMediaItem?
    @State private var isPlaying = false
    @State private var playbackTime: TimeInterval = 0
    @State private var duration: TimeInterval = 0
    
    private let musicPlayer = MPMusicPlayerController.systemMusicPlayer
    
    var body: some View {
        MusicWidgetView(
            nowPlaying: nowPlaying,
            isPlaying: isPlaying,
            playbackTime: playbackTime,
            duration: duration
        )
        .onAppear {
            loadMusicState()
            startTimer()
        }
    }
    
    private func loadMusicState() {
        nowPlaying = musicPlayer.nowPlayingItem
        isPlaying = musicPlayer.playbackState == .playing
        playbackTime = musicPlayer.currentPlaybackTime
        duration = nowPlaying?.playbackDuration ?? 0
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            loadMusicState()
        }
    }
}

