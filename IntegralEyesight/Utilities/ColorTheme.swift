import Foundation
import SwiftUI

/// Defines the color theme for the `IntegralEyesight` app.
///
/// This enum provides a centralized way to manage and access color schemes used throughout the application.
/// It defines static properties for different colors, such as background and text colors, ensuring consistency in the app's visual design.
enum ColorTheme {
    /// The background color used in the app, retrieved from the asset catalog.
    static let backgroundColor = Color("BackgroundColor")

    /// The text color used in the app, retrieved from the asset catalog.
    static let textColor = Color("TextColor")
}
