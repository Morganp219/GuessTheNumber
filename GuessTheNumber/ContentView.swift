//
//  ContentView.swift
//  GuessTheNumber
//
//  Created by Morgan Pritchard on 4/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput = ""
    @State private var vm = GameModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                GameView(userInput: $userInput, vm: $vm)
                    .frame(height: geometry.size.height * 0.5)
                    .frame(maxWidth: .infinity)

                VStack {
                    if !vm.attemptGuesses.isEmpty {
                        Guesses(data: vm.attemptGuesses)
                    } else {
                        Text("No Guesses Attempted Yet!")
                            .foregroundColor(.secondary)
                    }
                }
                .frame(height: geometry.size.height * 0.5)
                .frame(maxWidth: .infinity)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(.systemBlue).opacity(0.2),
                        Color(.systemTeal).opacity(0.2),
                        Color(.systemIndigo).opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
