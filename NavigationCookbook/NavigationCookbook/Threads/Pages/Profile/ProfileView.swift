import SwiftUI

struct ProfileView: View {
    @ObserveInjection var inject

    @ObservedObject var userViewModel = UserService.shared

    @State private var selectedFilter = ProfileThreadFilter.threads

    @Namespace var animation

    var body: some View {

        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text(userViewModel.currentUser?.email ?? "")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(userViewModel.currentUser?.id ?? "")
                            .font(.subheadline)
                        if let bio = userViewModel.currentUser?.bio {
                            Text(bio)
                                .font(.footnote)
                        }
                    }

                    Spacer()

                    Avatar()
                }

                Button {
                    print("Follow")
                } label: {
                    Text("Edit Profile")
                        .modifier(ExpandedFilledButtonStyle())
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        ForEach(ProfileThreadFilter.allCases) { filter in
                            VStack {
                                Text(filter.title)
                                    .font(.subheadline)
                                    .foregroundColor(
                                        selectedFilter == filter
                                            ? .primary : .secondary
                                    )
                                    .fontWeight(
                                        selectedFilter == filter
                                            ? .semibold : .regular)

                                if selectedFilter == filter {
                                    Rectangle()
                                        .foregroundColor(.primary)
                                        .frame(height: 1)
                                        .matchedGeometryEffect(
                                            id: "filter", in: animation)
                                } else {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(height: 1)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedFilter = filter
                                }
                            }
                        }
                    }

                    LazyVStack {
                        ForEach(0..<10) { index in
                            ThreadCell()
                        }
                    }
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 16)
            .navigationTitle("Profile")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)

                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                })
            #endif
        }
        .enableInjection()
    }
}

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        }
    }
}
