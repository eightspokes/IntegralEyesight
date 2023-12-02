import SwiftUI

/// The main application structure for `IntegralEyesight`.
///
/// This struct sets up the application's environment and provides the initial view.
/// It creates and injects `VimeoViewModel` and `FavoriteVideosViewModel` as environment objects,
/// making them accessible throughout the app. The base view of the application is `BaseView`.
@main
struct IntegralEyesightApp: App {
    /// State object for `VimeoViewModel` which interacts with the Vimeo service.
    @StateObject var vimeoViewModel = VimeoViewModel(service: VimeoService())

    /// State object for managing favorite videos.
    @StateObject var favorites = FavoriteVideosViewModel()

    /// The body of the application, defining its content and behavior.
    var body: some Scene {
        WindowGroup {
            BaseView()
                .preferredColorScheme(.dark) // Sets the preferred color scheme for the app.
                .environmentObject(vimeoViewModel) // Provides `VimeoViewModel` to the environment.
                .environmentObject(favorites) // Provides `FavoriteVideosViewModel` to the environment.
        }
    }
}
