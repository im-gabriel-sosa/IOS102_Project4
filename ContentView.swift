//
//  ContentView.swift
//  memoryGame
//
//  Created by Gabriella Valdes on 3/2/25.
//

import SwiftUI

//for vgrid
let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

struct ContentView: View {
    @State private var cards: [Card] = Card.mockedCards.shuffled() // Shuffle on start
    @State private var flippedIndices: [Int] = [] // Track flipped card indices

    var body: some View {
        VStack {
            // Reset Button
            Button(action: resetGame) {
                Text("Reset Game")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(
                            card: cards[index],
                            isFlipped: Binding(
                                get: { flippedIndices.contains(index) },
                                set: { newValue in
                                    if newValue {
                                        if flippedIndices.count < 2 {
                                            flippedIndices.append(index)
                                        }
                                    } else {
                                        flippedIndices.removeAll { $0 == index }
                                    }
                                    checkMatch()
                                }
                            )
                        )
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                .padding()
            }
            .frame(maxHeight: 800)
        }
    }

    // Reset function to restart the game
    func resetGame() {
        cards = Card.mockedCards.shuffled() // Shuffle cards
        flippedIndices.removeAll() // Reset flipped cards
    }

    func checkMatch() {
        if flippedIndices.count == 2 {
            let firstIndex = flippedIndices[0]
            let secondIndex = flippedIndices[1]

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if cards[firstIndex].answer == cards[secondIndex].answer {
                    // Remove matched cards
                    cards.remove(at: max(firstIndex, secondIndex)) // Remove in reverse order
                    cards.remove(at: min(firstIndex, secondIndex))
                }
                flippedIndices.removeAll()
            }
        }
    }
}

#Preview {
    ContentView()
}
