
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var displayLabel: UILabel!
    
    private var _userIsInTheMiddleOfTyping: Bool = false
    private var _brain = CalculatorBrain()
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if _userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = displayLabel.text!
            displayLabel.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel.text = digit
        }
        _userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if _userIsInTheMiddleOfTyping {
            _brain.setOperand(displayValue)
            _userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            _brain.performOperation(mathematicalSymbol)
        }
        displayValue = _brain.result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}