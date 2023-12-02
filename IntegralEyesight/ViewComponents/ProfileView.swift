import SwiftUI

/// `ProfileView` is a view that displays a profile header.
///
/// This view presents the application's icon, a title, and a profile picture.
/// It adapts to the current color scheme (dark or light mode) by changing the app icon color.
/// The profile picture is rendered using `ProfilePictureView`.
///
/// - Parameters:
///   - title: The title displayed next to the app icon. Defaults to "Integral Eyesight Improvement".
struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    /// The title displayed next to the app icon.
    private let title = "Integral Eyesight\nImprovement"

    /// The content and behavior of the view.
    var body: some View {
        HStack(alignment: .bottom) {
            Image(colorScheme == .dark ? "AppIconWhite" : "AppIconBlack")
                .resizable()
                .scaledToFit()
                .frame(width: 65)
            Text(title)
                .lineSpacing(-2)
                .bold()
                .italic()
            Spacer()
            ProfilePictureView(image: "ProfilePicture")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

/// Provides a preview of the `ProfileView`.
#Preview {
    ProfileView()
}
