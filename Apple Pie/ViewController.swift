//
//  ViewController.swift
//  Apple Pie
//
//  Created by Konstantin Ryabtsev on 21.12.2021.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var globalListOfWords = [
        "Барсук",
        "Бабочка",
        "Белка",
        "Бурундук",
        "Медведь",
        "Волк",
        "Енот",
        "Ёж",
        "Жук",
        "Заяц",
        "Зубр",
        "Кабан",
        "Крот",
        "Куница",
        "Лисица",
        "Лось",
        "Мангуст",
        "Муравьи",
        "Мышь",
        "Олень",
        "Опоссум",
        "Росомаха",
        "Рысь",
        "Скунс",
        "Соболь",
        "Стрекоза",
        "Тигр"
    ]
    var currentListOfWords: [String]!
    
    var totalRounds = 0
    var totalWins = 0
    var totalLosses = 0

    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newGame() {
        currentListOfWords = globalListOfWords.shuffled()
        totalRounds = 0
        totalWins = 0
        totalLosses = 0
        newRound()
    }
    
    func newRound() {
        guard !currentListOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        
        let newWord = currentListOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        totalRounds += 1
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
            newRound()
        } else if currentGame.guessedWord == currentGame.currentWord {
            totalWins += 1
            newRound()
        } else {
            updateUI()
        }
    }
    
    func updateUI() {
        let movesRemaining = (currentGame.incorrectMovesRemaining + 8) % 8
        let image = "Tree\(movesRemaining)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses), Раунд: \(totalRounds)(\(currentListOfWords.count))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    //MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func showWordButtonPressed(_ sender: UIButton) {
        totalLosses += 1
        
        for letter in currentGame.currentWord {
            currentGame.playerGuessed(letter: letter)
        }
        
        enableButtons(false)
        updateUI()
    }
    
    @IBAction func nextWordButtonPressed(_ sender: UIButton) {
        newRound()
    }
}

