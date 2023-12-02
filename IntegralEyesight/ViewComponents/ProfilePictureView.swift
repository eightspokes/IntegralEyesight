import SwiftUI

/// `ProfilePictureView` displays a profile picture with an optional circular gradient border.
///
/// This view takes an optional `image` parameter, which is the name of the image to be displayed.
/// If no image is provided, it defaults to a generic icon. The image is displayed as a circle with a multi-colored gradient border.
///
/// - Parameters:
///   - image: The name of the image to be displayed. Defaults to "default-icon" if not provided.
struct ProfilePictureView: View {
    /// The name of the image to be displayed.
    var image: String?

    /// Returns the name of the profile image to be used, falling back to a default if none is provided.
    private var profileImage: String {
        return image ?? "default-icon"
    }

    /// The content and behavior of the view.
    var body: some View {
        VStack {
            Image(profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(
                            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                            lineWidth: 2)
                )
        }
    }
}

#Preview {
    ProfilePictureView(image: "ProfilePicture")
}

