//
//  ViewController.swift
//  Trivia Game
//
//  Created by Sawyer Shirley on 10/18/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    
    var questions = [TriviaQuestion]()
    
    var questionsPlaceholder = [TriviaQuestion]()
    
    var currentIndex: Int!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score) Points"
        }
    }
    
    var currentQuestion: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuestion {
                questionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColors()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "candy2.png")!)
        populateQuestions()
        getNewQuestion()
    }
    
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "What is older than sliced bread?", answers: ["Betty White", "Apple-bottomed Jeans", "Scooby-Doo", "Miranda Jessie" ], correctAnswerIndex: 0)
        let question2 = TriviaQuestion(question: "What is NOT a common type of cake?", answers: ["Potato Cake", "Blackberry Cake", "Banana Cake", "Strawberry Cake"], correctAnswerIndex: 2)
        let question3 = TriviaQuestion(question: "What is the best type of cookie?", answers: ["Chocolate Chip", "Sugar Cookie", "Snickerdoodle", "All cookies are best cookies"], correctAnswerIndex: 3)
        let question4 = TriviaQuestion(question: "What breakfast cereal was Sonny the Cuckoo Bird 'cuckoo for'?", answers: ["Trix", "Cocoa Puffs", "Fruit Loops", "Cocoa Pebbles"], correctAnswerIndex: 1)
        questions = [question1, question2, question3, question4]
    }
    
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count)
            currentQuestion = questions[currentIndex]
        } else {
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let gameOverAlert = UIAlertController(title: "Game OVER!", message: "You scored \(score) out of \(questionsPlaceholder.count)", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Play Again!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.resetGame()
        }
        gameOverAlert.addAction(okAction)
        self.present(gameOverAlert, animated: true, completion: nil)
    }
    
    let backgroundColors = [
        UIColor(red: 248/255, green: 107/255, blue: 50/255, alpha: 1.0),
        UIColor(red: 239/255, green: 135/255, blue: 207/255, alpha: 1.0),
        UIColor(red: 61/255, green: 249/255, blue: 152/255, alpha: 1.0),
        UIColor(red: 195/255, green: 95/255, blue: 242/255, alpha: 1.0)
    ]
    
    func setNewColors() {
        let randomNumber = Int.random(in: 1...1000)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        answerAButton.backgroundColor = randomColorA
        answerBButton.backgroundColor = randomColorB
        answerCButton.backgroundColor = randomColorC
        answerDButton.backgroundColor = randomColorD
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        if sender.tag == currentQuestion.correctAnswerIndex {
            showCorrectAnswerAlert()
            score += 1
        } else {
            showIncorrectAnswerAlert()
        }
    }
    
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "CORRECT", message: "Great job! You got the right answer!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Yas!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        correctAlert.addAction(okAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    func showIncorrectAnswerAlert() {
        let incorrectAlert = UIAlertController(title: "INCORRECT", message: "You have failed your team! '\(currentQuestion.correctAnswer)' is the correct answer.", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Awe poo!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsPlaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsPlaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsPlaceholder
        questionsPlaceholder.removeAll()
        getNewQuestion()
    }
    
    @IBAction func unwindToQuizScreen(segue:UIStoryboardSegue){}
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetGame()
    }
    
}
