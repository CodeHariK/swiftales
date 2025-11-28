import PhotosUI
import SwiftUI

struct EditProfileView: View {
    @ObserveInjection var inject

    @State private var bio = ""
    @State private var isPrivateProfile = false

    @Environment(\.dismiss) private var dismiss

    @ObservedObject var userViewModel = UserService.shared

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])

                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name")
                                .fontWeight(.semibold)

                            Text("Stella Solea")
                                .font(.subheadline)
                        }
                        Spacer()

                        let profileImage = userViewModel.profileImage
                        PhotosPicker(
                            selection: $userViewModel.selectedItem,
                            matching: .images
                        ) {
                            if let image = profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Avatar()
                            }
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Bio").fontWeight(.semibold)
                        TextField("Enter your bio", text: $bio, axis: .vertical)
                    }

                    Divider()

                    Toggle("Private Profile", isOn: $isPrivateProfile)
                }
                .font(.footnote)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(
                        Color(.systemGray), lineWidth: 1)
                )
                .padding()
            }
            .navigationTitle("Edit Profile")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            #if os(iOS)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                try await userViewModel.updateUserData(
                                    bio: bio)
                            }
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                })
            #endif
        }

        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
