//
//  ViewController.swift
//  Counter
//
//  Created by dmitry on 16.08.2024.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IB Outlets
    
    @IBOutlet weak private var counterLabel: UILabel!
    @IBOutlet weak private var plusButton: UIButton!
    @IBOutlet weak private var minusButton: UIButton!
    @IBOutlet weak private var resetButton: UIButton!
    @IBOutlet weak private var infoTextView: UITextView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plusButton.layer.cornerRadius = 10
        minusButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        infoTextView.layer.cornerRadius = 10
    }

    //MARK: - IB Actions
    
    @IBAction private func resetButtonPressed() {
        counterLabel.text = "0"
        showReport(withMessage: "значение сброшено")
    }
    
    @IBAction private func plusButtonPressed() {
        guard let counterValue = counterLabel.text,
              let counterValue = Int(counterValue)
        else { return }
        counterLabel.text = String(counterValue + 1)
        showReport(withMessage: "значение изменено на +1")
    }
    
    @IBAction private func minusButtonPressed() {
        guard let counterValue = counterLabel.text,
              let counterValue = Int(counterValue)
        else { return }
        if counterValue > 0 {
            counterLabel.text = String(counterValue - 1)
            showReport(withMessage: "значение изменено на -1")
        } else {
            showReport(withMessage: "попытка уменьшить значение счетчика меньше 0")
        }
    }
    
    //MARK: - Private Methods
    
    private func showReport(withMessage message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        let currentDate = dateFormatter.string(from: Date.init())
        infoTextView.text += "\n\(currentDate): \(message)"
    }
}
