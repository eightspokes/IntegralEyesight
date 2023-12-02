import SwiftUI

/// The home view for the `IntegralEyesight` app.
///
/// This view displays the main content of the home screen, including a profile view,
/// an announcement section, and a scrollable list of course folders fetched from the Vimeo API.
/// It conditionally shows an announcement view if the user is not registered for an event
/// and displays course folders using `CourseCard`.
struct HomeView: View {
    /// The title for the announcement section.
    let announcementTitle = "Registration for the next Vision Tune Up series is now open!"

    /// The body text for the announcement section.
    let announcementBody = "November 1st – 30th, 2023"

    /// State to track if the user is registered for an event.
    @State var isRegisteredForEvent = false

    /// The view model to interact with Vimeo services.
    @EnvironmentObject var vimeoViewModel: VimeoViewModel

    /// The color scheme of the environment.
    @Environment(\.colorScheme) var colorScheme

    /// The content and behavior of the view.
    var body: some View {
        NavigationStack {
            ZStack {
                ColorTheme.backgroundColor.ignoresSafeArea()

                VStack {
                    ProfileView()
                    if !isRegisteredForEvent {
                        AnnouncementView(isRegistered: $isRegisteredForEvent, titleText: announcementTitle, bodyText: announcementBody)

                        if !vimeoViewModel.isFetchFoldersInRootLoading {
                            ScrollView(.vertical) {
                                ForEach(vimeoViewModel.foldersInRootFolder, id: \.name) { folder in
                                    if folder.name != "Legal Disclaimer" {
                                        NavigationLink {
                                            CourseDetailedView(courseName: folder.name, videosUri: folder.uri)
                                        } label: {
                                            VStack(alignment: .leading) {
                                                Text(folder.name)
                                                    .font(.title)
                                                    .foregroundColor(ColorTheme.textColor)
                                                CourseCard(cardImage: folder.name)
                                            }
                                        }
                                    }
                                }
                            }
                             .padding(.horizontal)
                        } else {
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .task {
                    do {
                        try await vimeoViewModel.fetchFoldersInRootFolder()
                    } catch {
                        print("Error fetching folders from Vimeo API: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(VimeoViewModel(service: VimeoService()))
        .preferredColorScheme(.dark)

}


