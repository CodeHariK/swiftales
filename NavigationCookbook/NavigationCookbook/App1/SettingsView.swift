//
//  SettingsView.swift
//  swiftales
//
//  Created by Shark on 29/10/25.
//

import SwiftUI

struct App1SettingsViewContent: View {

    @ObserveInjection var inject

    @State private var notificationsEnabled = true
    @State private var biometricEnabled = true
    @State private var darkModeEnabled = false
    @State private var autoLockEnabled = true
    @State private var selectedCurrency = "USD"
    @State private var selectedLanguage = "English"

    let currencies = ["USD", "EUR", "GBP", "INR", "JPY"]
    let languages = ["English", "Spanish", "French", "German", "Italian"]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    #if os(iOS)
                        // Safe area spacer
                        Color.clear.frame(height: geometry.safeAreaInsets.top)
                    #endif

                    // Header
                    HStack {
                        Text("Settings")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)

                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    // Account Section
                    SettingsSection(title: "Account") {
                        SettingsRow(
                            icon: "person.circle.fill",
                            title: "Profile Information",
                            subtitle: "Manage your personal details",
                            action: {}
                        )

                        SettingsRow(
                            icon: "creditcard.fill",
                            title: "Payment Methods",
                            subtitle: "Add or remove payment methods",
                            action: {}
                        )

                        SettingsRow(
                            icon: "shield.fill",
                            title: "Security",
                            subtitle: "Password, PIN, and security settings",
                            action: {}
                        )
                    }

                    // Preferences Section
                    SettingsSection(title: "Preferences") {
                        SettingsToggleRow(
                            icon: "bell.fill",
                            title: "Notifications",
                            subtitle: "Push notifications and alerts",
                            isOn: $notificationsEnabled
                        )

                        SettingsToggleRow(
                            icon: "faceid",
                            title: "Biometric Authentication",
                            subtitle: "Use Face ID or Touch ID",
                            isOn: $biometricEnabled
                        )

                        SettingsToggleRow(
                            icon: "moon.fill",
                            title: "Dark Mode",
                            subtitle: "Switch between light and dark themes",
                            isOn: $darkModeEnabled
                        )

                        SettingsToggleRow(
                            icon: "lock.fill",
                            title: "Auto Lock",
                            subtitle: "Automatically lock the app",
                            isOn: $autoLockEnabled
                        )
                    }

                    // App Settings Section
                    SettingsSection(title: "App Settings") {
                        SettingsPickerRow(
                            icon: "dollarsign.circle.fill",
                            title: "Currency",
                            subtitle: "Default currency for transactions",
                            selection: $selectedCurrency,
                            options: currencies
                        )

                        SettingsPickerRow(
                            icon: "globe",
                            title: "Language",
                            subtitle: "App language and region",
                            selection: $selectedLanguage,
                            options: languages
                        )
                    }

                    // Support Section
                    SettingsSection(title: "Support") {
                        SettingsRow(
                            icon: "questionmark.circle.fill",
                            title: "Help Center",
                            subtitle: "Get help and support",
                            action: {}
                        )

                        SettingsRow(
                            icon: "envelope.fill",
                            title: "Contact Us",
                            subtitle: "Send us a message",
                            action: {}
                        )

                        SettingsRow(
                            icon: "star.fill",
                            title: "Rate App",
                            subtitle: "Rate us on the App Store",
                            action: {}
                        )
                    }

                    // Legal Section
                    SettingsSection(title: "Legal") {
                        SettingsRow(
                            icon: "doc.text.fill",
                            title: "Terms of Service",
                            subtitle: "Read our terms and conditions",
                            action: {}
                        )

                        SettingsRow(
                            icon: "hand.raised.fill",
                            title: "Privacy Policy",
                            subtitle: "How we protect your data",
                            action: {}
                        )
                    }

                    // Sign Out Button
                    Button(action: {
                        // Sign out action
                    }) {
                        Text("Sign Out")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                }
            }
            #if os(macOS)
                .background(Color(NSColor.controlBackgroundColor))
            #else
                .background(Color(.systemBackground))
                .ignoresSafeArea()
                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                    Color.clear
                    .frame(height: 0)
                    .background(Material.bar)
                }
            #endif
        }
        .enableInjection()
    }
}

struct App1SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var biometricEnabled = true
    @State private var darkModeEnabled = false
    @State private var autoLockEnabled = true
    @State private var selectedCurrency = "USD"
    @State private var selectedLanguage = "English"

    var body: some View {
        NavigationView {
            App1SettingsViewContent()
                #if os(iOS)
                    .navigationBarHidden(true)
                #endif
        }
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 12)

            VStack(spacing: 0) {
                content
            }
            #if os(macOS)
                .background(Color(NSColor.textBackgroundColor))
            #else
                .background(Color(.secondarySystemBackground))
            #endif
            .cornerRadius(12)
            .padding(.horizontal, 24)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.97, green: 0.22, blue: 0.34))
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)

                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingsToggleRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 0.97, green: 0.22, blue: 0.34))
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: Color(red: 0.97, green: 0.22, blue: 0.34)))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

struct SettingsPickerRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var selection: String
    let options: [String]

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 0.97, green: 0.22, blue: 0.34))
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }

            Spacer()

            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accentColor(Color(red: 0.97, green: 0.22, blue: 0.34))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

#Preview {
    App1SettingsView()
}
