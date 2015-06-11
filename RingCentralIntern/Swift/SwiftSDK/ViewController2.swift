import Foundation


import UIKit

class ViewController2: UIViewController {
    
    
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var numberText: UILabel!
    
    @IBOutlet var addNumber: UIButton!
    @IBOutlet var table: UITableView!
    
    @IBAction func sliding(sender: UISlider) {
        numberText.text = "\(sender.value - sender.value%1)"
    }
    
    @IBAction func toggle(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            eventTitle.text = "Pool Planner"
        } else {
            eventTitle.text = "PingPong Planner"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addNumber.layer.cornerRadius = 5
        addNumber.layer.borderWidth = 1
        addNumber.layer.borderColor = UIColor.blackColor().CGColor
        addNumber.backgroundColor = UIColor.blueColor()
        
    }
    
    @IBAction func pressedAdd(sender: UIButton) {
        
    }
    
}