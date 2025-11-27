import Combine
import FirebaseAuth
import SwiftUI

class ThreadsAppModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()

    init() {
        AuthService.shared.$userSession.sink { [weak self] user in
            self?.userSession = user
        }.store(in: &cancellables)
    }
}

struct ThreadsApp: View {

    @StateObject var viewModel = ThreadsAppModel()

    var body: some View {

        Group {
            if viewModel.userSession != nil {
                ThreadsTabView()
            } else {
                LoginView()
            }
        }

        // EditProfileView()
        // CreateThreadView()
    }
}
