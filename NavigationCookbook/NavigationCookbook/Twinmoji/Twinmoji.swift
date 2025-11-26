import SwiftUI

enum GameState {
    case wating
    case player1Answering
    case player2Answering
    case gameOver
}

struct TwinmojiGame: View {
    @ObserveInjection var inject

    @State private var answerTime = 1.0
    @State private var itemCount = 9
    @State private var isGameActive = false

    var body: some View {
        Group {
            if isGameActive {
                TwinmojiGameContent(
                    itemCount: itemCount,
                    answerTime: answerTime,
                    isGameActive: $isGameActive
                )
            } else {
                VStack(spacing: 10) {
                    Text("Twinmoji")
                        .font(.largeTitle)
                        .padding()

                    Picker("Timeout Time", selection: $answerTime) {
                        Text("Slow").tag(2.0)
                        Text("Medium").tag(1.0)
                        Text("Fast").tag(0.5)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom)
                    .cornerRadius(10)

                    Picker(selection: $itemCount, label: Text("Difficulty")) {
                        Text("Level 1").tag(6)
                        Text("Level 2").tag(9)
                        Text("Level 3").tag(12)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom)

                    Button("Start Game") {
                        isGameActive = true
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding()
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(Color(white: 0.9))
            }
        }
        .enableInjection()
    }
}

struct TwinmojiGameContent: View {

    let allEmojis = [
        "🍎", "🍌", "🍇", "🍓", "🍒", "🍑", "🍊", "🍋", "🍐", "🍏",
        "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣",
        "🥲", "🥹", "🤯", "🤠", "🥳", "🥸", "🤩", "🤗", "🤫", "🤭",
        "🤔", "🤨", "🙄",
    ]

    @State private var currentEmojis = [String]()
    @State private var leftCard = [String]()
    @State private var rightCard = [String]()

    @State private var gameState = GameState.wating

    @State private var player1Score = 0
    @State private var player2Score = 0

    @State private var answerColor = Color.clear
    @State private var answerScale = 1.0
    @State private var answerAnchor = UnitPoint.center

    @State private var playerHasWon = false

    var itemCount: Int
    var answerTime: Double
    @Binding var isGameActive: Bool

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                TwinmojiScorePanel(
                    gameState: gameState,
                    score: player1Score,
                    color: Color.blue)

                ZStack {

                    answerColor
                        .scaleEffect(x: answerScale, anchor: answerAnchor)

                    if leftCard.isEmpty == false {
                        HStack {
                            TwinmojiCardView(
                                card: leftCard,
                                userCanAnswer: gameState == .wating,
                                onSelect: checkAnswer)
                            TwinmojiCardView(
                                card: rightCard,
                                userCanAnswer: gameState == .wating,
                                onSelect: checkAnswer)
                        }
                        .padding(.horizontal, 10)
                    }
                }

                TwinmojiScorePanel(
                    gameState: gameState,
                    score: player2Score,
                    color: Color.red
                )
            }

            Button("Reset Game", systemImage: "arrow.counterclockwise") {
                isGameActive = false
                playerHasWon = false
            }
            .buttonStyle(.plain)
            .padding(20)
            .labelStyle(.iconOnly)
            .background(Color.black)
            .clipShape(.rect(cornerRadius: 20))
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.9))
        .persistentSystemOverlays(Visibility.hidden)
        .onAppear {
            createLevel()
        }
        .alert("Game Over", isPresented: $playerHasWon) {
            Button(
                "Play Again",
                action: {
                    isGameActive = false
                    playerHasWon = false
                })
        } message: {
            Text("Player \(playerHasWon ? "1" : "2") has won the game!")
        }
    }

    func createLevel() {
        currentEmojis = allEmojis.shuffled()

        withAnimation(.spring(duration: answerTime)) {
            leftCard = Array(currentEmojis[0..<itemCount])  //.shuffled()
            rightCard = Array(
                currentEmojis[(itemCount + 1)..<(itemCount * 2)]
                    + [currentEmojis[0]]
            )  //.shuffled()
        }
    }

    func timeOut(for emoji: [String]) {

        guard currentEmojis == emoji else {
            return
        }

        if gameState == .player1Answering {
            player1Score -= 1
        } else {
            player2Score -= 1
        }
        gameState = .wating
    }

    func runClock() {
        answerScale = 1.0
        let checkEmoji = currentEmojis

        withAnimation(.linear(duration: 1.0)) {
            answerScale = 0
        } completion: {
            timeOut(for: checkEmoji)
        }
    }

    func checkAnswer(text: String) {
        if text == currentEmojis[0] {
            if gameState == .player1Answering {
                player1Score += 1
            } else {
                player2Score += 1
            }

            if player1Score == 5 || player2Score == 5 {
                gameState = .gameOver
                playerHasWon = true
            } else {
                createLevel()
            }
        } else {
            if gameState == .player1Answering {
                player1Score -= 1
            } else {
                player2Score -= 1
            }
        }

        answerScale = 0
        answerColor = .clear

        gameState = .wating
        createLevel()
    }
}

struct TwinmojiCardView: View {
    var card: [String]
    var userCanAnswer: Bool
    var onSelect: (String) -> Void

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
                        let text = card[row * 3 + column]
                        Button {
                            onSelect(text)
                        } label: {
                            Text(text)
                                .font(.system(size: 40))
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 20))
        .fixedSize()
        .shadow(radius: 10)
        .disabled(userCanAnswer == false)
        .transition(.push(from: .top))
        .id(card)
    }
}

struct TwinmojiScorePanel: View {
    var gameState: GameState
    var score: Int
    var color: Color

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(minWidth: 60, maxWidth: 120)
            .cornerRadius(10)
            .shadow(radius: 10)
            .overlay {
                Text(String(score))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
    }
}
