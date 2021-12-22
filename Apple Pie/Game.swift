//
//  Game.swift
//  Apple Pie
//
//  Created by Konstantin Ryabtsev on 21.12.2021.
//

struct Game {
    var currentWord: String
    var incorrectMovesRemaining: Int
    private var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.currentWord = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String {
        var wordToShow = String()
        
        for letter in currentWord {
            if guessedLetters.contains(Character(letter.lowercased())) || letter == "-" || letter == " " {
                wordToShow += String(letter)
            } else {
                wordToShow += "_"
            }
        }
        
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !currentWord.lowercased().contains(lowercasedLetter) {
            incorrectMovesRemaining = incorrectMovesRemaining <= 0 ? 0 : incorrectMovesRemaining - 1
        }
    }
}
