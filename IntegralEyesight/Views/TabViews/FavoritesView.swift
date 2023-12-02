import SwiftUI

/// A view for displaying the user's favorite videos.
///
/// This view shows a list of favorite videos using `FavoriteVideosViewModel`.
/// Each video is presented as a `VideoCardView`, and users can navigate to a detailed view for each video.
struct FavoritesView: View {
    /// The view model for managing favorite videos.
    @EnvironmentObject var favorites: FavoriteVideosViewModel

    /// The content and behavior of the view.
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(favorites.favoriteVideos, id: \.name) { video in
                    NavigationLink {
                        VideoView(video: video)
                    } label: {
                        VideoCardView(video: video)
                    }
                }
            }
            .navigationTitle("Favorite Videos")
        }
    }
}


#Preview {
    FavoritesView()
        .environmentObject(FavoriteVideosViewModel())
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)

}
