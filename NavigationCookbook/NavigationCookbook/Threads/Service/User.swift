import FirebaseAuth
import FirebaseFirestore
import Foundation
import Combine

class UserService: ObservableObject {
    @Published var currentUser: ThreadsUser?

    static let shared = UserService()

    // init() {
    //     Task {
    //         try? await getCurrentUser()
    //     }
    // }

    @MainActor
    func getCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User not found", code: 0, userInfo: nil)
        }

        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        let doc = try await docRef.getDocument()

        if doc.exists {
            let data = doc.data()
            let user = ThreadsUser(id: uid, email: data?["email"] as? String ?? "", profileImageURL: data?["profileImageURL"] as? String ?? "", bio: data?["bio"] as? String ?? "")
            currentUser = user
            NSLog("User loaded: \(user)")
        }
    }
}
