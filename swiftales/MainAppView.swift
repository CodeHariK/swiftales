//
//  MainAppView.swift
//  swiftales
//
//  Created by Shark on 29/10/25.
//

import SwiftUI

struct MainAppView: View {
    @State private var selectedTab = 0

    var body: some View {
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

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(Color(red: 0.97, green: 0.22, blue: 0.34))
    }
}

#Preview {
    MainAppView()
}
