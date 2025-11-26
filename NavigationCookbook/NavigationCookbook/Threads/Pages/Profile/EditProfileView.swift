import SwiftUI

struct EditProfileView: View {
    @ObserveInjection var inject

    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemFill)
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

                        Avatar()
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Bio").fontWeight(.semibold)
                        TextField("Enter your bio", text: $bio, axis: .vertical)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Link").fontWeight(.semibold)
                        TextField("Enter your link", text: $link)
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
                            print("Cancel")
                        } label: {
                            Text("Cancel")
                        }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Save")
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
