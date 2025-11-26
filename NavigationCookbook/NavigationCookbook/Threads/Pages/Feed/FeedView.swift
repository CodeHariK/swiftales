import SwiftUI

struct FeedView: View {
    @ObserveInjection var inject

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0..<10, id: \.self) { index in
                        ThreadCell()
                    }
                }
            }
            .refreshable {
                // Refresh the feed
            }
            .navigationTitle("Threads")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                    }
                }
            #endif
        }

        //----------------------------------
        .enableInjection()
        //----------------------------------

    }
}
