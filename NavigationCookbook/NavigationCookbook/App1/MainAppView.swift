//
//  MainAppView.swift
//  swiftales
//
//  Created by Shark on 29/10/25.
//

import SwiftUI

enum App1Section: String, CaseIterable, Identifiable {
    case home = "Home"
    case profile = "Profile"
    case settings = "Settings"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .profile: return "person.fill"
        case .settings: return "gearshape.fill"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            #if os(macOS)
                HomeViewContent()
            #else
                HomeView()
            #endif
        case .profile:
            #if os(macOS)
                ProfileViewContent()
            #else
                ProfileView()
            #endif
        case .settings:
            #if os(macOS)
                App1SettingsViewContent()
            #else
                App1SettingsView()
            #endif
        }
    }
}

struct MainAppView: View {
    @State private var selectedTab = 0
    #if os(macOS)
        @State private var selectedSection: App1Section? = .home
        @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    #endif

    var body: some View {
        #if os(macOS)
            NavigationSplitView(columnVisibility: $columnVisibility) {
                List(selection: $selectedSection) {
                    ForEach(App1Section.allCases) { section in
                        NavigationLink(value: section) {
                            Label(section.rawValue, systemImage: section.icon)
                        }
                    }
                }
                .navigationTitle("Navigation")
            } detail: {
                NavigationStack {
                    if let selectedSection = selectedSection {
                        selectedSection.view
                    } else {
                        Text("Select an item")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .accentColor(Color(red: 0.97, green: 0.22, blue: 0.34))
        #else
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(1)

                App1SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    .tag(2)
            }
            .accentColor(Color(red: 0.97, green: 0.22, blue: 0.34))
        #endif
    }
}

#Preview {
    MainAppView()
}
