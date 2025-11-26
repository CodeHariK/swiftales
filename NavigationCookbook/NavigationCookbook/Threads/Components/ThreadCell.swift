import SwiftUI

struct ThreadCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Avatar()

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Stella Solea")
                            .font(.subheadline)
                            .fontWeight(.semibold)

                        Spacer()

                        Text("12:00 PM")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Menu {
                            Button(action: {}) {
                                Label("Edit", systemImage: "pencil")
                            }

                            Button(action: {}) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }
                        .menuStyle(.borderlessButton)
                        .menuIndicator(.hidden)
                    }

                    Text("I'm so happy today!")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)

                    HStack {
                        Button(action: {}) {
                            Image(systemName: "heart")
                                .font(.system(size: 16))
                        }

                        Button(action: {}) {
                            Image(systemName: "message")
                                .font(.system(size: 16))
                        }

                        Button(action: {}) {
                            Image(systemName: "bookmark")
                                .font(.system(size: 16))
                        }

                        Text("100")
                            .font(.caption)

                    }
                }

            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .cornerRadius(16)
        }

        Divider()
    }
}
