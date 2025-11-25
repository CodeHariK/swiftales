//
//  ContentView.swift
//  swiftales
//
//  Created by Shark on 28/10/25.
//

import SwiftUI

struct ProfileViewContent: View {

    @ObserveInjection var inject

    @State private var email = "stella@gmail.com"
    @State private var password = "***********"
    @State private var pincode = "450116"
    @State private var address = "216 St Paul's Rd,"
    @State private var city = "London"
    @State private var state = "N1 2LL,"
    @State private var country = "United Kingdom"
    @State private var bankAccount = "204356XXXXXXX"
    @State private var accountHolder = "Solea Stella"
    @State private var ifscCode = "SBIN00428"

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    #if os(iOS)
                        // Safe area spacer
                        Color.clear.frame(height: geometry.safeAreaInsets.top)
                    #endif

                    // Header with back button and title
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 19))
                                .foregroundColor(.primary)
                        }

                        Spacer()

                        Text("Checkout")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)

                        Spacer()

                        // Invisible button for balance
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 19))
                                .opacity(0)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    // Profile Image Section
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 100, height: 100)

                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)

                            // Edit button
                            Button(action: {}) {
                                ZStack {
                                    Circle()
                                        #if os(macOS)
                                            .fill(Color(NSColor.controlBackgroundColor))
                                        #else
                                            .fill(Color(.systemBackground))
                                        #endif
                                        .frame(width: 32, height: 32)
                                        .shadow(radius: 2)

                                    Image(systemName: "pencil")
                                        .font(.system(size: 18))
                                        .foregroundColor(.primary)
                                }
                            }
                            .offset(x: 35, y: 35)
                        }
                    }
                    .padding(.top, 40)

                    // Personal Details Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Personal Details")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 24)

                        VStack(spacing: 12) {
                            // Email Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Email Address")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $email)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // Password Field
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Password")
                                        .font(.system(size: 12))
                                        .foregroundColor(.primary)

                                    Spacer()

                                    Button("Change Password") {
                                        // Change password action
                                    }
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(Color(red: 0.97, green: 0.22, blue: 0.34))
                                }

                                TextField("", text: $password)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 20)

                    // Divider
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    // Business Address Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Business Address Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 24)

                        VStack(spacing: 12) {
                            // Pincode Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Pincode")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $pincode)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // Address Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Address")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $address)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // City Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("City")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $city)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // State Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("State")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                HStack {
                                    TextField("", text: $state)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.horizontal, 20)

                                    Spacer()

                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                                }
                                .frame(height: 48)
                                #if os(macOS)
                                    .background(Color(NSColor.textBackgroundColor))
                                #else
                                    .background(Color(.secondarySystemBackground))
                                #endif
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                )
                            }

                            // Country Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Country")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $country)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 20)

                    // Divider
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    // Bank Account Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Bank Account Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 24)

                        VStack(spacing: 12) {
                            // Bank Account Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Bank Account Number")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $bankAccount)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // Account Holder Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Account Holder's Name")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $accountHolder)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }

                            // IFSC Code Field
                            VStack(alignment: .leading, spacing: 4) {
                                Text("IFSC Code")
                                    .font(.system(size: 12))
                                    .foregroundColor(.primary)

                                TextField("", text: $ifscCode)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 20)
                                    .frame(height: 48)
                                    #if os(macOS)
                                        .background(Color(NSColor.textBackgroundColor))
                                    #else
                                        .background(Color(.secondarySystemBackground))
                                    #endif
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.8), lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 20)

                    // Save Button
                    Button(action: {
                        // Save profile action
                    }) {
                        Text("Save")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color(red: 0.97, green: 0.22, blue: 0.34))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
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

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ProfileViewContent()
        }
    }
}
