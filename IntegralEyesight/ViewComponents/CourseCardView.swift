import SwiftUI

struct CourseCard: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    let cornerRadius = 15
    var cardImage: String
    let description: String = "This is a description of the course. It can be two to three sentences long. It should describe what this course is about."

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

    private func isLandscape() -> Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard(cardImage: "Instructional Videos")
    }
}
