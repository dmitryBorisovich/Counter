import UIKit

class ViewController: UIViewController {

    //MARK: - IB Outlets
    
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak private var plusButton: UIButton!
    @IBOutlet weak private var minusButton: UIButton!
    @IBOutlet weak private var resetButton: UIButton!
    @IBOutlet weak private var infoTextView: UITextView!
    @IBOutlet weak private var clearHistoryButton: UIButton!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [plusButton,
        minusButton,
        resetButton,
        infoTextView,
        clearHistoryButton].forEach { $0?.layer.cornerRadius = 10 }
        
        let value = UserDefaults.standard.object(forKey: "counterValue") as? String ?? "0"
        counterLabel.text = value
        
        let changeStory = UserDefaults.standard.object(forKey: "infoText") as? String ?? "История изменений:"
        infoTextView.text = changeStory
    }

    //MARK: - IB Actions
    
    @IBAction private func resetButtonPressed() {
        counterLabel.text = "0"
        showReport(withMessage: "значение сброшено")
        saveCounter()
    }
    
    @IBAction private func plusButtonPressed() {
        guard let counterValue = counterLabel.text,
              let counterValue = Int(counterValue)
        else { return }
        counterLabel.text = String(counterValue + 1)
        showReport(withMessage: "значение изменено на +1")
        saveCounter()
    }
    
    @IBAction private func minusButtonPressed() {
        guard let counterValue = counterLabel.text,
              let counterValue = Int(counterValue)
        else { return }
        if counterValue > 0 {
            counterLabel.text = String(counterValue - 1)
            showReport(withMessage: "значение изменено на -1")
            saveCounter()
        } else {
            showReport(withMessage: "попытка уменьшить значение счетчика меньше 0")
        }
    }
    
    @IBAction func clearHistoryButtonPressed() {
        infoTextView.text = "История изменений:"
        saveChangeStory()
    }
    //MARK: - Private Methods
    
    private func showReport(withMessage message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        let currentDate = dateFormatter.string(from: Date())
        infoTextView.text += "\n\(currentDate): \(message)"
        
        saveChangeStory()
        
        let location = infoTextView.text.count - 1
        let bottom = NSMakeRange(location, 1)
        infoTextView.scrollRangeToVisible(bottom)
    }
    
    private func saveCounter() {
        UserDefaults.standard.set(counterLabel.text, forKey: "counterValue")
    }
    
    private func saveChangeStory() {
        UserDefaults.standard.set(infoTextView.text, forKey: "infoText")
    }
}
