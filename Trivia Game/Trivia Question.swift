//
//  Trivia Question.swift
//  Trivia Game
//
//  Created by Sawyer Shirley on 10/19/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation

class TriviaQuestion {
    
    //String storing the text of the question
    let question: String
    //String array storing the possible answers
    let answers: [String]
    //Int storing the index of the correct answer
    let correctAnswerIndex: Int
    //Computed property that returns the correct answer using the answer index
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    init(question: String, answers: [String], correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    

    
    
    
}
