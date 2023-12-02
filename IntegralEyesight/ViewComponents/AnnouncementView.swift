import SwiftUI

/// `AnnouncementView` is a view for displaying announcements, with a title, body text, and a register button.
///
/// This view adapts to the current color scheme (dark or light mode) for its background.
/// It takes a `titleText` and `bodyText` to display the announcement content.
/// The `isRegistered` state is provided to potentially handle registration logic.
///
/// - Parameters:
///   - isRegistered: A binding to a Boolean value indicating whether the user is registered.
///   - titleText: The title text of the announcement.
///   - bodyText: The detailed body text of the announcement.
struct AnnouncementView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isRegistered: Bool
    let titleText: String
    let bodyText: String

    /// The content and behavior of the view.
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundColor( colorScheme == .dark ? ColorTheme.backgroundColor.lighter(by: 20) : ColorTheme.backgroundColor.darker(by: 20))
                .frame(height: 130)
                .cornerRadius(10)
                .padding()

            VStack(alignment: .leading) {
                Text(titleText)
                    .font(.headline).bold()

                Text(bodyText)

                HStack {
                    Spacer()
                    Button {
                        //TODO: Implement registration functionality
                    } label: {
                        Text("Register")
                            .bold()
                            .frame(width: 150, height: 25)
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
            .padding([.top, .leading, .trailing], 25)
        }
    }
}

#Preview {
    AnnouncementView(isRegistered: .constant(false), titleText: "Registration for the next Vision Tune Up series is now open!", bodyText: "November 1st – 30th, 2023")
        .preferredColorScheme(.dark)
}

