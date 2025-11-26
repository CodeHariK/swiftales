import SwiftUI

struct CreateThreadView: View {
    @ObserveInjection var inject

    @State private var caption = ""

    var body: some View {
        NavigationStack {

            VStack {
                HStack {
                    Avatar()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Stella Solea")
                            .font(.subheadline)

                        TextField(
                            "Enter your caption", text: $caption,
                            axis: .vertical)
                    }

                    Spacer()

                    if !caption.isEmpty {
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()
            }
            .font(.footnote)
            .padding()
            .navigationTitle("Create Thread")
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
                            print("Post")
                        } label: {
                            Text("Post")
                        }
                        .disabled(caption.isEmpty)
                    }
                })
            #endif
        }

        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
