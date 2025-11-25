import SwiftUI

struct App2: View {
    @ObserveInjection var inject

    let allEmojis = [
        "🍎", "🍌", "🍇", "🍓", "🍒", "🍑", "🍊", "🍋", "🍐", "🍏",
        "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣",
        "🥲", "🥹", "🤯", "🤠", "🥳", "🥸", "🤩", "🤗", "🤫", "🤭",
        "🤔", "🤨", "🙄", "🤔", "🤨", "🙄", "🤔", "🤨",
        "🙄",
    ]

    @State private var currentEmojis = [String]()
    @State private var leftCard = [String]()
    @State private var rightCard = [String]()

    var itemCount: Int

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if leftCard.isEmpty == false {
                    HStack {
                        CardView(card: leftCard)
                        CardView(card: rightCard)
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.9))
        .persistentSystemOverlays(Visibility.hidden)
        .onAppear {
            createLevel()
        }
        .enableInjection()
    }

    func createLevel() {
        currentEmojis = allEmojis.shuffled()

        withAnimation(.spring(duration: 0.75)) {
            leftCard = Array(currentEmojis[0..<itemCount]).shuffled()
            rightCard = Array(
                currentEmojis[(itemCount + 1)..<(itemCount * 2)]
                    + [currentEmojis[0]]
            ).shuffled()
        }
    }
}

struct CardView: View {
    var card: [String]

    var rows: Int {
        if card.count == 12 {
            4
        } else {
            3
        }
    }

    var body: some View {
        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
            ForEach(0..<rows, id: \.self) { row in
                GridRow {
                    ForEach(0..<3) { column in
                        Button {
                            NSLog("Card pressed")
                        } label: {
                            Text(card[row * 3 + column])
                                .font(.system(size: 40))
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
