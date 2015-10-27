//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var currentLetters: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var guesses: UILabel!
    
    var theGame: Hangman!
    var wrongCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hangmanImage.image = UIImage(named: "hangman1")
        currentLetters.text = ""
        
    }
    
    @IBAction func makeNewGame() {
        self.theGame = Hangman()
        self.theGame.start()
        
        self.guesses.text = ""
        self.currentLetters.text = self.theGame.knownString
        
        // Reset guesses and Hangman picture
        self.wrongCount = 0
        hangmanImage.image = UIImage(named: ("hangman1.gif"))
    }
    
    @IBAction func doGuess() {
        if self.theGame == nil {
            return
        }
        print(inputText.text)
        print (self.theGame.answer)
        let input = inputText.text!.capitalizedString
        
        if input.characters.count != 1 {
            return
        }

        let isCorrect = self.theGame.guessLetter(input)
        
        self.guesses.text = self.theGame.guesses()
        self.currentLetters.text = self.theGame.knownString
        print(self.theGame.knownString)
        
        if (!isCorrect) {
            self.wrongCount += 1
            drawHangMan()
        }
        
        
        notify()
    }
    
    func notify() {
        // Implement this
        
        let goToNewGameHandler = { (action: UIAlertAction!) -> Void in
            self.makeNewGame()
        }
        
        let newGameAction = UIAlertAction(title: "New Game", style: .Default, handler: goToNewGameHandler)
        
        if (wrongCount > 6) {
            let gameLost = UIAlertController(title: "Hangman Died :(", message: "You lose! Try again?", preferredStyle: UIAlertControllerStyle.Alert)
            
            gameLost.addAction(newGameAction)
            presentViewController(gameLost, animated: true, completion: nil)
        }
        
        if self.theGame.knownString!.rangeOfString("_") == nil {
            let gameWon = UIAlertController(title: "Hangman survived!", message: "Nice, you won! Play Again!", preferredStyle: UIAlertControllerStyle.Alert)
            
            gameWon.addAction(newGameAction)
            presentViewController(gameWon, animated: true, completion: nil)
        }
        
        
    }
    
    func drawHangMan() {
        print(self.wrongCount)
        switch self.wrongCount {
        case 1:
            hangmanImage.image = UIImage(named: ("hangman1.gif"))
        case 2:
            hangmanImage.image = UIImage(named: ("hangman2.gif"))
        case 3:
            hangmanImage.image = UIImage(named: ("hangman3.gif"))
        case 4:
            hangmanImage.image = UIImage(named: ("hangman4.gif"))
        case 5:
            hangmanImage.image = UIImage(named: ("hangman5.gif"))
        case 6:
            hangmanImage.image = UIImage(named: ("hangman6.gif"))
        case 7:
            hangmanImage.image = UIImage(named: ("hangman7.gif"))
        default:
            print("default bro")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

