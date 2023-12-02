import SwiftUI

/// Represents a theme with color definitions used throughout the app.
enum Theme {
    /// The primary color theme.
    static let primary = Color("Primary")
}

/// The base view for the `IntegralEyesight` app.
///
/// This view serves as the main container, organizing the app's content into different tabs.
/// Currently, it includes tabs for the home view and favorites view, with a placeholder for a future progress view.
struct BaseView: View {

    /// The content and behavior of the view.
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            // Placeholder for the future ProgressView.
            /*
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "calendar")
                }
            */
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
        .accentColor(ColorTheme.textColor) // Sets the accent color for the tab view.
    }
}

/// Provides a preview for `BaseView`.
///
/// Includes environment objects for `VimeoViewModel` and `FavoriteVideosViewModel`,
/// and sets the preferred color scheme to dark mode.
#if DEBUG
struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BaseView()
                .environmentObject(VimeoViewModel(service: VimeoService()))
                .environmentObject(FavoriteVideosViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
#endif
