//
//  GameModel.swift
//  GuessTheNumber
//
//  Created by Morgan Pritchard on 4/11/25.
//
import Foundation

struct GameModel {
    private let secret: Int
    private(set) var attempts = 0
    private(set) var attemptGuesses: [Guess] = []

    init() {
        self.secret = 0
    }
    
    mutating func makeGuess(_ guess: Int) -> GuessResponse {
        attempts += 1
        var result: GuessResponse = GuessResponse.LOW
        if(guess == secret) {
            result = GuessResponse.CORRECT
        } else if(guess < secret) {
            result = GuessResponse.LOW
        } else {
            result = GuessResponse.HIGH
        }
        let newGuess = Guess(attemptNumber: attempts, inputedValue: guess, result: result)
        attemptGuesses.append(newGuess)
        return result
    }
    
}


enum GuessResponse {
    case CORRECT, HIGH, LOW
}
struct Guess: Identifiable {
    let id = UUID()
    let attemptNumber: Int
    let inputedValue: Int
    let result: GuessResponse
}

extension Guess {
    func getReadableText() -> String {
        switch(result) {
            case GuessResponse.CORRECT:
                return "Correct!"
            case GuessResponse.HIGH:
                return "High!"
            case GuessResponse.LOW:
                return "Low!"
        }
    }
}
