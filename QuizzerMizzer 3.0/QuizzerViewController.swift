//
//  QuizzerViewController.swift
//  QuizzerMizzer 3.0
//
//  Created by Pritesh Rajyaguru on 5/8/23.
//

import UIKit


class QuizzerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizModels = [Questions]()
    
    var currentQuestion: Questions?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupQuestions()
        configureUI(question: quizModels.first!)
    }
    
    private func configureUI(question: Questions) {
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Questions) -> Bool {
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    private func setupQuestions() {
        quizModels.append(Questions(text: "What is one of the differences between PRE and POST increments in JAVA?", answers: [
            Answer(text: "PRE = after, POST = before", correct: false),
            Answer(text: "PRE = less instructions, POST = more Instructions", correct: true),
            Answer(text: "PRE = more instructions, POST = less instructions", correct: false),
            Answer(text: "There is no difference!", correct: false)
        ]))
        
        quizModels.append(Questions(text: "What is the name of the coding language used to create applications on IOS devices?", answers: [
            Answer(text: "JAVA", correct: false),
            Answer(text: "Python", correct: false),
            Answer(text: "Swift", correct: true),
            Answer(text: "C++", correct: false)
        ]))
        
        quizModels.append(Questions(text: "Why does a simple app like this use so much code? :(", answers: [
            Answer(text: "Just cuz", correct: true),
            Answer(text: "Apple doesn't like you", correct: true),
            Answer(text: "There's a lot going on in the background", correct: true),
            Answer(text: "It's easier to navigate for the user", correct: true)
        ]))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let question = currentQuestion else {
            return
        }
        let answer = question.answers[indexPath.row]
        if checkAnswer(answer: answer, question: question) {
            if let index = quizModels.firstIndex(where: {$0.text == question.text}) {
                if index  < (quizModels.count - 1) {
                    let nextQuestion = quizModels[index + 1]
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                } else {
                    let alert = UIAlertController(title: "Finished", message: "That's the end of the quiz!!!" ,preferredStyle: .alert)
                    let vc = storyboard?.instantiateViewController(identifier: "start") as! ViewController
                    vc.modalPresentationStyle = .fullScreen
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Wrong", message: "That is Incorrect :(" ,preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}

struct Questions {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool
}
