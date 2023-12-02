import Foundation

/// Represents the response structure when fetching data from the root Vimeo folder.
struct RootFolderResponse: Codable {
    let total: Int
    let page: Int
    let perPage: Int
    let paging: Paging
    let data: [FolderData]

    enum CodingKeys: String, CodingKey {
        case total, page, data, paging
        case perPage = "per_page"
    }
}

/// Contains pagination information for traversing through lists of data.
struct Paging: Codable {
    let next: String?
    let previous: String?
    let first: String
    let last: String
}

/// Represents data about a specific folder in the Vimeo API response.
struct FolderData: Codable {
    let type: String
    let folder: Folder
}

/// Represents details of a folder in the Vimeo API response.
struct Folder: Codable {
    let createdTime: String
    let modifiedTime: String
    let lastUserActionEventDate: String
    let name: String
    let privacy: Privacy
    let resourceKey: String
    let uri: String
    // Include other fields if necessary

    enum CodingKeys: String, CodingKey {
        case createdTime = "created_time"
        case modifiedTime = "modified_time"
        case lastUserActionEventDate = "last_user_action_event_date"
        case name, privacy, uri
        case resourceKey = "resource_key"
        // Map other fields as needed
    }
}

/// Represents privacy settings of a Vimeo folder.
struct Privacy: Codable {
    let view: String
}

/// Represents the response structure when fetching videos from a folder containing course materials on Vimeo.
struct VideosOfACourseResponse: Codable {
    let total: Int
    let page: Int
    let perPage: Int
    let paging: Paging
    let data: [VideoItem]

    enum CodingKeys: String, CodingKey {
        case total, page, data
        case perPage = "per_page"
        case paging
    }
}

/// Represents a video item in the Vimeo API response.
struct VideoItem: Codable {
    let type: String
    let video: Video
}

/// Represents file details of a video on Vimeo.
struct File: Codable, Hashable {
    let quality: String
    let rendition: String
    let type: String
    let width: Int?
    let height: Int?
    let link: String
    let fps: Int?
    let size: Int?
    let md5: String?
}

/// Represents details of a video on Vimeo.
struct Video: Codable, Hashable {
    let uri: String
    let name: String
    let description: String?
    let type: String
    let link: String
    let files: [File]?

    static let ExampleVideo: Video = Video(uri: "/videos/158064921", name: "Pinhole Glasses", description: "This video shows you how to use pinhole glasses to help you see more clearly near and far and how they can increase the rate that your eyes shift.", type: "video", link: "https://player.vimeo.com/progressive_redirect/playback/158064921/rendition/1080p/file.mp4?loc=external&oauth2_token_id=1751395057&signature=57bf99cd0550506f33348ecfa32335b18ef9ff8e4f582f3de5e0662efee761a5", files: nil)

    static func ==(lhs: Video, rhs: Video) -> Bool {
        lhs.uri == rhs.uri
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uri)
    }
}

/// Represents embedded HTML for a video on Vimeo.
struct Embed: Codable {
    let html: String
}
