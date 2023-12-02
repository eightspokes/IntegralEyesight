import SwiftUI

/// `CourseCard` is a view component that displays a course card with an image and a description.
///
/// This view adapts to different orientations by checking the horizontal and vertical size classes.
/// It displays the course image and a brief description. The layout changes based on whether the device is in landscape or portrait orientation.
///
/// - Parameters:
///   - cardImage: The name of the image to be displayed in the card.
///   - description: A brief description of the course. It is a static property with a default value.
struct CourseCard: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    /// The corner radius for the image.
    private let cornerRadius = 10
    /// The name of the image to be displayed in the card.
    var cardImage: String
    /// The description of the course.
    private let description: String = "Course Description"

    /// The content and behavior of the view.
    var body: some View {
        VStack(alignment: .leading) {
            Image(cardImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(CGFloat(cornerRadius))
                .frame(maxWidth: isLandscape() ? .infinity : nil, maxHeight: isLandscape() ? 200 : nil)

            Text(description)
                .padding(.horizontal)
                .font(.callout)
                .foregroundColor(ColorTheme.textColor)
        }
        .padding(isLandscape() ? .horizontal : .all)
    }

    /// Determines if the current device orientation is landscape.
    ///
    /// - Returns: A Boolean value indicating whether the device is in landscape orientation.
    private func isLandscape() -> Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
}

#Preview {
    CourseCard(cardImage: "Instructional Videos")
}
