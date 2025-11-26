import SwiftUI

struct ExploreView: View {

    @ObserveInjection var inject

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0..<10, id: \.self) { index in
                        ExploreItemView()
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
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
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Avatar()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Stella Solea")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text("I'm so happy today!")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Text("Follow")
                    .font(.subheadline)
                    .frame(width: 100, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray), lineWidth: 1)
                    )
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .cornerRadius(16)
        }

        Divider()
    }
}
