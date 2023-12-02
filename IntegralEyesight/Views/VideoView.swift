
import SwiftUI
import AVKit
import AVFoundation

/// A view that displays a video player for a specified video.
///
/// This view uses `AVPlayer` to play a video fetched from the Vimeo service.
/// It also includes a button to add or remove the video from the user's favorites.
/// The view depends on `VimeoViewModel` to fetch the video link and `FavoriteVideosViewModel` to manage favorites.
struct VideoView: View {
    /// The video to be played.
    var video: Video

    /// State for the AVPlayer instance.
    @State private var player = AVPlayer()

    /// The view model to interact with Vimeo services.
    @EnvironmentObject var vimeoViewModel: VimeoViewModel

    /// The view model for managing favorite videos.
    @EnvironmentObject var favorites: FavoriteVideosViewModel

    /// The content and behavior of the view.
    var body: some View {
        ZStack(alignment: .topLeading) {
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    if let link = vimeoViewModel.getLink(for: video, withQuality: "sd", andRendition: "360p") {
                        player = AVPlayer(url: URL(string: link)!)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        player.play()
                    }
                }

            Button {
                if favorites.contains(video) {
                    favorites.remove(video)
                } else {
                    favorites.add(video)
                }
            } label: {
                Group {
                    if favorites.contains(video) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                .font(.title)
                .transition(.scale) // Transition effect for both states
                .animation(.easeInOut(duration: 0.3), value: favorites.contains(video))
            }
        }
    }
}

#Preview {
    VideoView(video: Video.ExampleVideo)
        .environmentObject(VimeoViewModel(service: VimeoService()))
}
