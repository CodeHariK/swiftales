//
//  HomeView.swift
//  swiftales
//
//  Created by Shark on 29/10/25.
//

import SwiftUI

struct HomeViewContent: View {
    @ObserveInjection var inject

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
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)

                            Text("Solea Stella")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.primary)
                        }

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 24)

                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16
                        ) {
                            QuickActionCard(
                                title: "Send Money",
                                icon: "arrow.up.circle.fill",
                                color: Color(red: 0.97, green: 0.22, blue: 0.34)
                            )

                            QuickActionCard(
                                title: "Request Money",
                                icon: "arrow.down.circle.fill",
                                color: Color.blue
                            )

                            QuickActionCard(
                                title: "Pay Bills",
                                icon: "creditcard.fill",
                                color: Color.green
                            )

                            QuickActionCard(
                                title: "View History",
                                icon: "clock.fill",
                                color: Color.orange
                            )
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 30)

                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Transactions")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)

                            Spacer()

                            Button("View All") {
                                // View all transactions
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 0.97, green: 0.22, blue: 0.34))
                        }
                        .padding(.horizontal, 24)

                        VStack(spacing: 12) {
                            TransactionRow(
                                title: "Coffee Shop",
                                subtitle: "Food & Dining",
                                amount: "-$4.50",
                                isExpense: true
                            )

                            TransactionRow(
                                title: "Salary",
                                subtitle: "Income",
                                amount: "+$3,200.00",
                                isExpense: false
                            )

                            TransactionRow(
                                title: "Grocery Store",
                                subtitle: "Shopping",
                                amount: "-$85.30",
                                isExpense: true
                            )
                        }
                        .padding(.horizontal, 24)
                    }
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

struct HomeView: View {
    @ObserveInjection var inject

    var body: some View {
        NavigationView {
            HomeViewContent()
                #if os(iOS)
                    .navigationBarHidden(true)
                #endif
        }
        .enableInjection()
    }
}

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(color)

                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            #if os(macOS)
                .background(Color(NSColor.textBackgroundColor))
            #else
                .background(Color(.secondarySystemBackground))
            #endif
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct TransactionRow: View {
    let title: String
    let subtitle: String
    let amount: String
    let isExpense: Bool

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(isExpense ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: isExpense ? "arrow.up" : "arrow.down")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isExpense ? .red : .green)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(amount)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isExpense ? .red : .green)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeView()
}
