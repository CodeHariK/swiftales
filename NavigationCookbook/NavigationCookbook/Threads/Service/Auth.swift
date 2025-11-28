import Combine
import FirebaseAuth
import FirebaseFirestore
import Foundation

struct ThreadsUser: Identifiable, Codable, Hashable {
    let id: String
    let email: String
    let profileImageURL: String?
    let bio: String?
}

class AuthModal: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            email: email, password: password)
    }

    @MainActor
    func loginWithEmail() async throws {
        try await AuthService.shared.loginWithEmail(
            email: email, password: password)
    }
}

class AuthService {

    @Published var userSession: FirebaseAuth.User?
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    static let shared = AuthService()

    init() {
        self.authStateHandle = Auth.auth().addStateDidChangeListener {
            auth, user in

            NSLog(
                "--------> User session changed: \(user?.uid ?? "") \(user?.email ?? "")"
            )
            self.userSession = user

            if user != nil {
                Task {
                    try await UserService.shared.getCurrentUser()
                }
            }
        }
    }

    @MainActor
    func loginWithEmail(email: String, password: String) async throws {
        do {
            NSLog("Logging in", email, password)
            let result = try await Auth.auth().signIn(
                withEmail: email, password: password)
            NSLog("User logged in: \(result.user.uid)")
        } catch {
            NSLog("Error logging in: \(error)")
            throw error
        }
    }

    @MainActor
    func createUser(email: String, password: String) async throws {
        do {
            NSLog("Creating user")
            let result = try await Auth.auth().createUser(
                withEmail: email, password: password)
            NSLog("User created: \(result.user.uid)")
            try await uploadUserData(email: email)
        } catch {
            NSLog("Error creating user: \(error)")
            throw error
        }
    }

    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut()
            NSLog("User logged out")
        } catch {
            NSLog("Error logging out: \(error)")
        }
    }

    @MainActor
    private func uploadUserData(email: String) async throws {
        if userSession == nil {
            throw NSError(domain: "User session is nil", code: 0, userInfo: nil)
        }
        do {
            let user = ThreadsUser(
                id: userSession!.uid,
                email: email,
                profileImageURL: nil,
                bio: nil)

            let db = Firestore.firestore()
            let docRef = db.collection("users").document(userSession!.uid)
            try docRef.setData(
                from: user, encoder: Firestore.Encoder(), completion: nil)
        } catch {
            NSLog("Error uploading user data: \(error)")
            throw error
        }
    }
}
