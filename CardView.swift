//
//  CardView.swift
//  memoryGame
//
//  Created by Gabriella Valdes on 3/2/25.
//
import SwiftUI

struct CardView: View {
    let card: Card
    @Binding var isFlipped: Bool // Track if this card is flipped


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(isFlipped ? .indigo : .blue)
                .shadow(color: .black, radius: 4, x: -2, y: 2)


            VStack {
                Text(isFlipped ? card.answer : "")
            }
            .font(.system(size: 50, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
        }
        .frame(width: 110, height: 200)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}


struct Card {
    let question: String
    let answer: String
    
    static let mockedCards = [
            Card(question: "", answer: "🥂"),
            Card(question: "", answer: "❤️"),
            Card(question: "", answer: "😱"),
            Card(question: "", answer: "😁"),
            Card(question: "", answer: "😃"),
            Card(question: "", answer: "😇"),
            Card(question: "", answer: "🥂"),
            Card(question: "", answer: "❤️"),
            Card(question: "", answer: "😱"),
            Card(question: "", answer: "😁"),
            Card(question: "", answer: "😃"),
            Card(question: "", answer: "😇")
        ]
}

#Preview {
//    CardView(card: Card(
//        question: "",
//        answer: "❤️😱😁😃😇"))
}
