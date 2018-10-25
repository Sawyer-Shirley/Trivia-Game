//
//  AddQuestionViewController.swift
//  Trivia Game
//
//  Created by Sawyer Shirley on 10/19/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var newQuestionTextField: UITextField!
    
    @IBOutlet weak var answerATextField: UITextField!
    
    @IBOutlet weak var answerBTextField: UITextField!
    
    @IBOutlet weak var answerCTextField: UITextField!
    
    @IBOutlet weak var answerDTextField: UITextField!
    
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    
    var newTrivia: TriviaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "yas.png")!)
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    

    @IBAction func returnToQuizScreen(_ sender: Any) {
        performSegue(withIdentifier:"unwindSegueToQuizScreen", sender: self)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard
            let question = newQuestionTextField.text, !question.isEmpty,
            let a = answerATextField.text, !a.isEmpty,
            let b = answerBTextField.text, !b.isEmpty,
            let c = answerCTextField.text, !c.isEmpty,
            let d = answerDTextField.text, !d.isEmpty
            
        else {
            let errorAlert = UIAlertController(title: "EXCUSE ME Madam..", message: "Gorl, you gotta fill all of the areas for the question you want to add, or cancel. IDC, just pick something.", preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: "K", style: UIAlertAction.Style.default) { (UIAlertAction) in}
                errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
            }
        
        newTrivia = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: correctAnswerSelector.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindSegueToQuizScreen", sender: self)
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? QuizViewController,
            let newTriviaQuestion = newTrivia
            else { return }
        destinationVC.questions.append(newTriviaQuestion)
       // destinationVC.resetGame()
    }
}


