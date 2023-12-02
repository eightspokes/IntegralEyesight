import SwiftUI

/// A view that displays a card for a video.
///
/// This view shows a video thumbnail, the video's name, and a play icon overlay.
/// It adapts its layout based on the device's orientation (landscape or portrait).
/// The view fetches the video thumbnail image asynchronously using `VimeoViewModel`.
struct VideoCardView: View {
    /// The video to be displayed.
    var video: Video

    /// A sample image URL for the video's thumbnail.
    let sampleImageUrl = "/users/47826142/pictures/11187135"

    /// The view model to interact with Vimeo services.
    @EnvironmentObject var vimeoViewModel: VimeoViewModel

    /// The horizontal size class of the environment.
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    /// The vertical size class of the environment.
    @Environment(\.verticalSizeClass) var verticalSizeClass

    /// State for the image of the video thumbnail.
    @State var image: UIImage?

    /// The content and behavior of the view.
    var body: some View {
        let isLandscape = horizontalSizeClass == .regular && verticalSizeClass == .compact
        let frameHeight: CGFloat = isLandscape ? 300 : 400 // Adjusted height based on orientation

        ZStack {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(height: frameHeight)
                    .cornerRadius(30)
                    .padding(isLandscape ? .horizontal : .all)

                Image(video.name)
                    .resizable()
                    .scaledToFit()
                    .frame(height: frameHeight)
                    .cornerRadius(30)
                    .padding(isLandscape ? .horizontal : .all)

                Text(video.name)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
            }
            .task {
                do {
                    image = try await vimeoViewModel.getImage(url: sampleImageUrl)
                } catch {
                    print("Error getting image")
                }
            }

            Image(systemName: "play.fill")
                .foregroundStyle(.white)
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
        }
    }
}

#Preview {
    VideoCardView(video: Video.ExampleVideo)
        .environmentObject(VimeoViewModel(service: VimeoService()))
    
}
