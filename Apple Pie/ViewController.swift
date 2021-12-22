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
    var listOfWords = [
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
    var totalWins = 0
    var totalLosses = 0

    // MARK: - Methods
    func newRound() {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord {
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateUI() {
        let movesRemaining = (currentGame.incorrectMovesRemaining + 8) % 8
        let image = "Tree\(movesRemaining)"
        treeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    //MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateUI()
    }
    
}

