//
//  ViewController.swift
//  word garden
//
//  Created by Jess Newman on 2/5/18.
//  Copyright © 2018 Newman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsInGameLabel: UILabel!
    
    var wordsToGuess = ["SWIFT",
                        "LEAF",
                        "FLOWER",
                        "LAUGH",
                        "CODE",
                        "WATCH"]
    var wordToGuess = ""
    var wordToGuessIndex = 0
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordToGuess = wordsToGuess[wordToGuessIndex]
        wordsInGameLabel.text = "Words in Game: \(wordToGuess.count)"
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    //MARK:- Formatting Methods
    
    
    func updateWordsCountLabels() {
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
        wordsRemainingLabel.text = "Words Remaining: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
    }
    
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = "" 
    }
    
    func formatUserGuessLabel () {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _ "
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    //Mark:- Game Play Method
    
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        //DECREMENTS THE WRONGGUESSESREMAINING AND SHOWS THE NEXT FLOWER IMAGE WITH ONE LESS PEDAL
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        let revealedWord = userGuessLabel.text!
     //Stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
            wordsMissedCount += 1
        } else if !revealedWord.contains("_") {
            //You've won a game!
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You got it! It took you \(guessCount) guesses to guess the word!"
            wordsGuessedCount += 1
            updateWordsCountLabels()
        } else {
            //update our guess count
        
            let guess = ( guessCount == 1 ? "Guess" : "Guesses")
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
        if (wordsGuessedCount + wordsMissedCount) == wordsToGuess.count {
            guessCountLabel.text = "You've tried all of the words! Restart from the beginning?"
        }
    }
    
    //MARK:- @IBActions
    
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        } else {
            //disabled if i don't have a single character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }

    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()

    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        // What to do to reset user interface
        //increment to new word in the array
        wordToGuessIndex += 1
        if wordToGuessIndex == wordsToGuess.count {
            wordToGuessIndex = 0
            wordsGuessedCount = 0
            wordsMissedCount = 0
            updateWordsCountLabels()
        }
        wordToGuess = wordsToGuess[wordToGuessIndex]
        
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses."
        guessCount = 0
        
        
    }
    
    
}
