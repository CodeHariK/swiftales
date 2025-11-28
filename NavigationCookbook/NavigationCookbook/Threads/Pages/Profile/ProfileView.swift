import SwiftUI

struct UserProfileView: View {

    @ObserveInjection var inject

    var user: ThreadsUser

    @State private var selectedFilter = ProfileThreadFilter.threads

    @State private var showingEditProfileSheet = false

    @Namespace var animation

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.email)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(user.id)
                        .font(.subheadline)
                    if let bio = user.bio {
                        Text(bio)
                            .font(.footnote)
                    }
                }

                Spacer()

                Avatar()
            }

            if user.id != UserService.shared.currentUser?.id {
                FilledButton(action: {}, title: "Follow", flexible: true)
                    .padding(.vertical, 8)
            } else {
                HStack (spacing: 8){
                    OutlinedButton(action: {showingEditProfileSheet = true}, title: "Edit", flexible: true)
                    OutlinedButton(action: {}, title: "Share", flexible: true)
                }
                .padding(.horizontal, 8)
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
        .padding(16)
        .navigationTitle("Profile")
        .sheet(isPresented: $showingEditProfileSheet) {
            EditProfileView()
        }
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)

            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if user.id == UserService.shared.currentUser?.id {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "arrow.right").foregroundColor(
                                .primary)
                        }
                    }
                }
            })
        #endif

        //------------------
        .enableInjection()
        //------------------
    }
}

struct ProfileView: View {

    @ObservedObject var userViewModel = UserService.shared

    var user: ThreadsUser?

    var body: some View {

        if user != nil {
            UserProfileView(user: user!)
        } else if userViewModel.currentUser != nil {
            NavigationStack {
                UserProfileView(user: userViewModel.currentUser!)
            }
        } else {
            Text("User not found")
        }
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
