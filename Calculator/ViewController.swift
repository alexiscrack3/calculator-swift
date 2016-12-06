
import UIKit

class ViewController: UIViewController {
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    
    fileprivate var userIsInTheMiddleOfTyping = false
    fileprivate var brain = CalculatorBrain()
    var savedProgram: CalculatorBrain.PropertyList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        brain.addUnaryOperation(symbol: "Z") { [unowned me = self] in
//            me.displayLabel.textColor = UIColor.red
//            return sqrt($0)
//        }
        
        brain.addUnaryOperation(symbol: "Z") { [weak welf = self] in
            welf?.displayLabel.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
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
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
        savedProgram = brain.program
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
