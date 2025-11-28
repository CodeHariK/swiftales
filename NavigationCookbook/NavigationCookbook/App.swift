/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main app, which creates a scene that contains a window group, displaying
the root content view.
*/

import FirebaseCore
@_exported import Inject
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()

        return true
    }
}

@main
struct NavigationCookbookApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        #if DEBUG
            #if os(macOS)
                Bundle(
                    path:
                        "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"
                )?
                .load()
            #elseif os(iOS)
                Bundle(
                    path:
                        "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"
                )?
                .load()
            #elseif os(tvOS)
                Bundle(
                    path:
                        "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"
                )?
                .load()
            #endif
        #endif
    }

    var body: some Scene {
        WindowGroup {

            ThreadsApp()

                // TwinmojiGame().preferredColorScheme(.light)

                // MainAppView()
                // ContentView()

                #if os(macOS)
                    .frame(minWidth: 300, minHeight: 300)
                #endif
        }
        #if os(macOS)
            .commands {
                SidebarCommands()

                CommandMenu("Actions") {
                    Button("Run", systemImage: "play.fill") {
                        NSLog("Run")
                    }
                    .keyboardShortcut("R")

                    Button("Stop", systemImage: "stop.fill") {
                        NSLog("Stop")
                    }
                    .keyboardShortcut(".")
                }
            }
        #endif

        #if os(macOS)
            Settings {
                NavSettingsView()
            }
        #endif

    }
}
