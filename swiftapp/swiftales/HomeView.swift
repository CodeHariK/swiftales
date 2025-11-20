//
//  HomeView.swift
//  swiftales
//
//  Created by Shark on 29/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Status Bar
                    HStack {
                        Text("9:41")
                            .font(.system(size: 15, weight: .thin))
                            .italic()

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: "cellularbars")
                                .font(.system(size: 17))
                            Image(systemName: "wifi")
                                .font(.system(size: 15))
                            Image(systemName: "battery.100")
                                .font(.system(size: 22))
                        }
                    }
                    .padding(.horizontal, 21)
                    .padding(.top, 8)

                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)

                            Text("Abhiraj Sisodiya")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        }

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    // Quick Actions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Actions")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
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
                                .foregroundColor(.black)

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
            .background(Color(red: 0.99, green: 0.99, blue: 0.99))
            .navigationBarHidden(true)
        }
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
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(Color.white)
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
                    .foregroundColor(.black)

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
