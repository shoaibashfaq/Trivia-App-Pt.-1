import UIKit

class TriviaViewController: UIViewController {
    private var indexSelected = 0
    private var trivialData = [Question]()
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    @IBAction func optionSelected(_ sender: UIButton) {
            guard let index = [option1Button, option2Button, option3Button].firstIndex(of: sender) else {
                return
            }
            checkAns(index: index)
        }

    
    
    override func viewDidLoad() {
        trivialData = createDummyData();
        super.viewDidLoad()
        configure(q: trivialData[indexSelected])
    }
    
    
    private func configure(q: Question) {
        questionLabel.text = q.question
        questionLabel.sizeToFit()
        
        // Style option1Button
        styleButton(option1Button, with: q.options[0].sent)
        
        // Style option2Button
        styleButton(option2Button, with: q.options[1].sent)
        
        // Style option3Button
        styleButton(option3Button, with: q.options[2].sent)
    }

    private func checkAns(index: Int) {
        let selectedOption = trivialData[indexSelected].options[index]
        let message: String
        if selectedOption.isAns {
            message = "Correct!"
        } else {
            message = "Incorrect Answer. Please try again."
        }
        
        // Create an alert controller
        let alertController = UIAlertController(title: "Trivia", message: message, preferredStyle: .alert)
        
        // Add an OK action
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
        
        indexSelected += 1
        if indexSelected >= trivialData.count {
            indexSelected = 0 // Reset to the first question
        }
        configure(q: trivialData[indexSelected])
    }
    
    private func styleButton(_ button: UIButton, with title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.blue // Set your desired background color
        button.setTitleColor(UIColor.white, for: .normal) // Set text color
        button.layer.cornerRadius = 10 // Set corner radius
        button.layer.borderWidth = 1 // Set border width
        button.layer.borderColor = UIColor.black.cgColor // Set border color
    }
    
    private func createDummyData()->[Question]{
        let triviaData1 = Question(question: "Which planet is known as the Red Planet?",
                                  options: [
                                      Options(sent: "Mars", isAns: true),
                                      Options(sent: "Venus", isAns: false),
                                      Options(sent: "Jupiter", isAns: false)
                                  ])
        let triviaData2 = Question(question: "What is the chemical symbol for water?",
                                    options: [
                                        Options(sent: "H2O", isAns: true),
                                        Options(sent: "CO2", isAns: false),
                                        Options(sent: "O2", isAns: false)
                                    ])

        let triviaData3 = Question(question: "Who wrote the famous play 'Romeo and Juliet'?",
                                    options: [
                                        Options(sent: "William Shakespeare", isAns: true),
                                        Options(sent: "Charles Dickens", isAns: false),
                                        Options(sent: "Jane Austen", isAns: false)
                                    ])

        
                                      
        return [triviaData1,triviaData2,triviaData3]
    }
    
    
}
