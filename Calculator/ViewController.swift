
import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = displayLabel.text!
            displayLabel.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    fileprivate var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}
