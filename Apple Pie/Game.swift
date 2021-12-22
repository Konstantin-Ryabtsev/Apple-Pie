//
//  Game.swift
//  Apple Pie
//
//  Created by Konstantin Ryabtsev on 21.12.2021.
//

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    private var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String {
        var wordToShow = String()
        
        for letter in word {
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
        if !word.lowercased().contains(lowercasedLetter) {
            incorrectMovesRemaining = incorrectMovesRemaining <= 0 ? 0 : incorrectMovesRemaining - 1
        }
    }
}
