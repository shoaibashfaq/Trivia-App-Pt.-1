import UIKit

class TriviaViewController: UIViewController {
    private var indexSelected = 0
    private var triviaData = [Question]()
    private var questionCount = 0
    private var correctAnswers = 0
    
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        triviaData = createDummyData()
        configureQuestion()
    }
    
    private func configureQuestion() {
        guard indexSelected < triviaData.count && questionCount < 4 else {
              presentFinalResult()
              return
          }
        
        let currentQuestion = triviaData[indexSelected]
        
        questionCount += 1
        questionCountLabel.text = "Question \(questionCount)/\(triviaData.count)"
        questionLabel.text = currentQuestion.question
        questionLabel.sizeToFit()
        
        styleButton(option1Button, with: currentQuestion.options[0].sent)
        styleButton(option2Button, with: currentQuestion.options[1].sent)
        styleButton(option3Button, with: currentQuestion.options[2].sent)
    }
    
    private func presentFinalResult() {
        let scorePercentage = Double(correctAnswers) / Double(triviaData.count) * 100
        let message = "Trivia completed!\nYou answered \(correctAnswers) out of \(triviaData.count) questions correctly.\nScore: \(scorePercentage)%"
        let alertController = UIAlertController(title: "Results", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.resetTrivia()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetTrivia() {
        indexSelected = 0
        questionCount = 0
        correctAnswers = 0
        configureQuestion()
    }
    
    @IBAction func optionSelected(_ sender: UIButton) {
        guard let index = [option1Button, option2Button, option3Button].firstIndex(of: sender) else {
            return
        }
        checkAnswer(index: index)
    }
    
    private func checkAnswer(index: Int) {
        let selectedOption = triviaData[indexSelected].options[index]
        let message = selectedOption.isAns ? "Correct!" : "Incorrect Answer. Please try again."
        
        if selectedOption.isAns {
            correctAnswers += 1
        }
        
        let alertController = UIAlertController(title: "Trivia", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.indexSelected += 1
            self.configureQuestion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func styleButton(_ button: UIButton, with title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    private func createDummyData() -> [Question] {
        let triviaData = [
            Question(question: "Which planet is known as the Red Planet?",
                     options: [Options(sent: "Mars", isAns: true),
                               Options(sent: "Venus", isAns: false),
                               Options(sent: "Jupiter", isAns: false)]),
            Question(question: "What is the chemical symbol for water?",
                     options: [Options(sent: "H2O", isAns: true),
                               Options(sent: "CO2", isAns: false),
                               Options(sent: "O2", isAns: false)]),
            Question(question: "Who wrote the famous play 'Romeo and Juliet'?",
                     options: [Options(sent: "William Shakespeare", isAns: true),
                               Options(sent: "Charles Dickens", isAns: false),
                               Options(sent: "Jane Austen", isAns: false)]),
            Question(question: "What is the tallest mammal on Earth?",
                     options: [Options(sent: "Giraffe", isAns: true),
                               Options(sent: "Elephant", isAns: false),
                               Options(sent: "Hippo", isAns: false)])
        ]
        return triviaData
    }
}
