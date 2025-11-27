import SwiftUI

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

extension Color {
    // Helper to create adaptive colors
    #if os(iOS)
        private static func adaptiveColor(light: UIColor, dark: UIColor)
            -> Color
        {
            return Color(
                uiColor: UIColor { traitCollection in
                    traitCollection.userInterfaceStyle == .dark ? dark : light
                })
        }
    #elseif os(macOS)
        private static func adaptiveColor(light: NSColor, dark: NSColor)
            -> Color
        {
            return Color(
                nsColor: NSColor(name: nil) { appearance in
                    appearance.name == .darkAqua ? dark : light
                })
        }
    #endif

    // Button colors - adapts automatically to light/dark mode
    static var buttonBackground: Color {
        #if os(iOS)
            return adaptiveColor(
                light: UIColor(white: 0.0, alpha: 1.0),  // Black in light mode
                dark: UIColor(white: 0.2, alpha: 1.0)  // Dark gray in dark mode
            )
        #else
            return adaptiveColor(
                light: NSColor(white: 0.0, alpha: 1.0),  // Black in light mode
                dark: NSColor(white: 0.2, alpha: 1.0)  // Dark gray in dark mode
            )
        #endif
    }

    static var buttonForeground: Color {
        return .white
    }

    // Form field colors
    static var formFieldBackground: Color {
        #if os(iOS)
            return Color(uiColor: .systemGray6)
        #else
            return Color(nsColor: .controlBackgroundColor)
        #endif
    }

    static var formFieldText: Color {
        #if os(iOS)
            return Color(uiColor: .label)
        #else
            return Color(nsColor: .labelColor)
        #endif
    }

    // Link colors
    static var linkText: Color {
        #if os(iOS)
            return Color(uiColor: .systemBlue)
        #else
            return Color(nsColor: .linkColor)
        #endif
    }
}
