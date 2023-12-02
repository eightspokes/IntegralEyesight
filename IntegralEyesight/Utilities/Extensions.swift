import Foundation
import SwiftUI

/// Extension to the SwiftUI `Color` struct, providing additional functionalities for color manipulation.
extension Color {
    /// Retrieves the RGBA components of the color.
    ///
    /// - Returns: A tuple containing the red, green, blue, and opacity components of the color.
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }
        return (r, g, b, o)
    }

    /// Lightens the color by a specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to lighten the color. Defaults to 30%.
    /// - Returns: The lightened color.
    func lighter(by percentage: CGFloat = 30.0) -> Color {
        return self.adjust(by: abs(percentage))
    }

    /// Darkens the color by a specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to darken the color. Defaults to 30%.
    /// - Returns: The darkened color.
    func darker(by percentage: CGFloat = 30.0) -> Color {
        return self.adjust(by: -1 * abs(percentage))
    }

    /// Adjusts the color by a specified percentage.
    ///
    /// - Parameter percentage: The percentage by which to adjust the color. Positive values lighten the color, while negative values darken it.
    /// - Returns: The adjusted color.
    private func adjust(by percentage: CGFloat = 30.0) -> Color {
        return Color(red: min(Double(self.components.red + percentage / 100), 1.0),
                     green: min(Double(self.components.green + percentage / 100), 1.0),
                     blue: min(Double(self.components.blue + percentage / 100), 1.0),
                     opacity: Double(self.components.opacity))
    }
}
