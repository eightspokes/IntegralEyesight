import SwiftUI

/// A view that displays detailed information about a specific course.
///
/// This view presents an introductory text and a scrollable list of videos associated with the course.
/// It uses `VimeoViewModel` to fetch the list of videos and displays each video using `VideoCardView`.
/// Users can navigate to individual videos by tapping on the video cards.
struct CourseDetailedView: View {
    /// The view model to interact with Vimeo services.
    @EnvironmentObject var vimeoViewModel: VimeoViewModel

    /// State for the list of videos in the course.
    @State var courseVideos: [VideoItem] = []

    /// The name of the course.
    let courseName: String

    /// The URI for fetching videos of the course.
    let videosUri: String

    /// The content and behavior of the view.
    var body: some View {
        NavigationStack {
            Text("These videos will help you to understand the fundamentals of natural vision improvement")
                .padding()
            ScrollView {
                ForEach(courseVideos, id: \.video.name) { video in
                    NavigationLink {
                        VideoView(video: video.video)
                    } label: {
                        VideoCardView(video: video.video)
                    }
                }
            }
            .task {
                do {
                    courseVideos = try await vimeoViewModel.fetchVideosInCourseFolder(from: videosUri)
                } catch {
                    print("Error!!: \(error)")
                }
            }
            .navigationTitle(courseName)
        }
    }
}
#Preview {
    CourseDetailedView(courseName: "Instructional Videos", videosUri: "users/47826142/projects/18611365")
        .environmentObject(VimeoViewModel(service: VimeoService()))
}
