/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main app, which creates a scene that contains a window group, displaying
 the root content view.
*/

@_exported import Inject
import SwiftUI

@main
struct NavigationCookbookApp: App {
    init() {
        #if DEBUG
            #if os(macOS)
                Bundle(
                    path: "/Applications/InjectionNext.app/Contents/Resources/macOSInjection.bundle")?
                    .load()
            #elseif os(iOS)
                Bundle(
                    path: "/Applications/InjectionNext.app/Contents/Resources/iOSInjection.bundle")?
                    .load()
            #elseif os(tvOS)
                Bundle(
                    path: "/Applications/InjectionNext.app/Contents/Resources/tvOSInjection.bundle")?
                    .load()
            #endif
        // Enable animation for hot reload
        //            InjectConfiguration.animation = .interactiveSpring()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                #if os(macOS)
                    .frame(minWidth: 800, minHeight: 600)
                #endif
        }
        #if os(macOS)
            .commands {
                SidebarCommands()
            }
        #endif
    }
}
