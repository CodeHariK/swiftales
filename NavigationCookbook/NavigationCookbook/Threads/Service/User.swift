import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Foundation
import PhotosUI
import SwiftUI

class UserService: ObservableObject {
    @Published var currentUser: ThreadsUser?

    static let shared = UserService()

    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
    @Published var profileImage: Image?

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
            let user = ThreadsUser(
                id: uid,
                email: data?["email"] as? String ?? "",
                profileImageURL: data?["profileImageURL"] as? String ?? "",
                bio: data?["bio"] as? String ?? "")
            currentUser = user
            NSLog("--------> User loaded: \(user)")
        }
    }

    @MainActor
    func getUsers() async throws -> [ThreadsUser] {

        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User not found", code: 0, userInfo: nil)
        }

        let db = Firestore.firestore()
        let docRef = db.collection("users")
        let snapshot = try await docRef.getDocuments()

        let users = snapshot.documents.compactMap({
            try? $0.data(
                as: ThreadsUser.self, with: .none, decoder: Firestore.Decoder())
        })

        NSLog("--------> Users loaded: \(users)")

        return users.filter { $0.id != uid }
    }

    @MainActor
    func updateUserData(bio: String?) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "User not found", code: 0, userInfo: nil)
        }

        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        var data: [String: Any] = [:]
        if let bio = bio {
            data["bio"] = bio
        }
        try await docRef.updateData(data)
    }

    @MainActor
    func uploadImage(_ image: UIImage) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            throw NSError(
                domain: "Failed to convert image to data", code: 0,
                userInfo: nil)
        }

        let filename = NSUUID().uuidString

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let imageRef = storageRef.child("profile_images/").child(filename)

        do {
            let _ = try await imageRef.putDataAsync(imageData)
            let url = try await imageRef.downloadURL()

            try await Firestore.firestore()
            .collection("users")
            .document(Auth.auth().currentUser!.uid)
            .updateData(["profileImageURL": url.absoluteString])
        } catch {
            throw NSError(
                domain: "Failed to upload image", code: 0, userInfo: nil)
        }

        // uploadTask.observe(.success) { snapshot in
        //     if let metadata = snapshot.metadata {
        //         let downloadURL = metadata.fullPath
        //         print("Image uploaded successfully: \(downloadURL)")
        //     }
        // }
    }

    @MainActor
    private func loadImage() async {
        guard let selectedItem = selectedItem else { return }

        do {
            guard
                let data = try await selectedItem.loadTransferable(
                    type: Data.self)
            else { return }
            guard let uiImage = UIImage(data: data) else { return }
            profileImage = Image(uiImage: uiImage)
        } catch {
            print("Error loading image: \(error)")
        }
    }
}
