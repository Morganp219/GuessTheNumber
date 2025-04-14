//
//  Guesses.swift
//  GuessTheNumber
//
//  Created by Morgan Pritchard on 4/11/25.
//

import SwiftUI

struct Guesses: View {
    var data: [Guess]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Guess History")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 5)

            ForEach(data) { guess in
                HStack {
                    Text("#\(guess.attemptNumber)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 80, alignment: .leading)

                    Text("Guessed: \(guess.inputedValue)")
                        .font(.body)
                        .frame(width: 120, alignment: .leading)

                    Text(guess.getReadableText())
                        .font(.callout)
                        .foregroundColor(colorForResult(guess.result))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                )
            }
        }
        .padding()
    }

    func colorForResult(_ result: GuessResponse) -> Color {
        switch result {
        case .HIGH:
            return .red
        case .LOW:
            return .blue
        case .CORRECT:
            return .green
        }
    }

}


#Preview {
    Guesses(data: [Guess(attemptNumber: 0, inputedValue: 22, result: .HIGH)])
}
