//
//  GameView.swift
//  GuessTheNumber
//
//  Created by Morgan Pritchard on 4/14/25.
//

import SwiftUI

struct GameView: View {
    @Binding var userInput: String
    @State private var error: String = ""
    @Binding var vm: GameModel
    @State private var response: String = ""
    @State private var reponseColor: Color = Color.red

    var body: some View {
        VStack(spacing: 20) {
            Text("🎯 Guess the Number")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            TextField("Enter your guess...", text: $userInput)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(error.isEmpty ? Color.blue : Color.red, lineWidth: 2)
                )
                .padding(.horizontal)

            if !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .font(.callout)
                    .transition(.opacity)
            }
            
            if !response.isEmpty {
                VStack {
                    Text("You are:")
                        .font(.title)
                        .bold()
                    Text(response)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(reponseColor)
                }
                
            }

            Spacer()
            
            Button {
                let cleaned = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
                print(userInput)
                guard let guess = Int(cleaned) else {
                    error = "🚫 Invalid number!"
                    response = ""
                    return
                }

                let res = vm.makeGuess(guess)

                switch res {
                case .CORRECT:
                    response = "Correct!"
                    reponseColor = .green
                case .HIGH:
                    response = "Too High"
                    reponseColor = .red
                case .LOW:
                    response = "Too Low"
                    reponseColor = .red
                }

            } label: {
                Text("I'm sure!")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.headline)
            }
        }
        .padding()
        .onChange(of: userInput) { _, newValue in
            if newValue.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
                error = "🚫 Only numbers are allowed!"
            } else {
                error = ""
            }
        }
    }
}

#Preview {
    GameView(userInput: .constant(""), vm: .constant(GameModel()))
}
