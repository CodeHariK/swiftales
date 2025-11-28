import Combine
import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var users: [ThreadsUser] = []

    init() {
        Task {
            do {
                let users = try await UserService.shared.getUsers()
                self.users = users
            } catch {
                NSLog("Error loading users: \(error)")
            }
        }
    }
}

struct ExploreView: View {

    @ObserveInjection var inject

    @State private var searchText = ""

    @StateObject private var viewModel = ExploreViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.users, id: \.self) { user in
                        NavigationLink(value: user) {
                            ExploreItemView(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .navigationDestination(for: ThreadsUser.self) { user in
                UserProfileView(user: user)
            }
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }

        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}

struct ExploreItemView: View {

    var user: ThreadsUser

    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 12) {
                Avatar()

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.email)
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("I'm so happy today!")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                OutlinedButton(action: {}, title: "Follow")
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .cornerRadius(16)
        }

        Divider()
    }
}
