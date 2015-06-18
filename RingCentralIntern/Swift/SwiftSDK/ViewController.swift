import UIKit
import Foundation

import CoreLocation

// Visual for the iPhone application.
class ViewController: UIViewController {
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var userBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var keyBox: UITextField!
    @IBOutlet weak var secretBox: UITextField!
    @IBOutlet var fromBox: UITextField!
    @IBOutlet var toBox: UITextField!
    @IBOutlet var messageBox: UITextField!
    
    @IBOutlet var loginButton: UIView!
    @IBOutlet var accountButton: UIButton!
    @IBOutlet var apiButton: UIButton!
    @IBOutlet var sendFaxButton: UIButton!
    @IBOutlet var sendSMSButton: UIButton!
    @IBOutlet var sendRingOutButton: UIButton!
    @IBOutlet var callLogButton: UIButton!
    @IBOutlet var presenceButton: UIButton!
    @IBOutlet var revokeButton: UIButton!
    
    @IBOutlet weak var status: UILabel!
    
    var app_key: String = "eI3RKs1oSBSY2kReFnviIw"
    var app_secret = "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ"
    var username = "13464448343"
    var password = "P@ssw0rd"
    let platform = Platform()
    var timer: NSTimer = NSTimer()
    
    var person: User = User(key: "",secret: "",user: "",pass: "")
    
    
    func login() {
        person = User(key: keyBox.text!, secret: secretBox.text!, user: userBox.text!, pass: passBox.text!)
    }
    
    
    func pressRevoke() {
        platform.revoke(person) { (bool: Bool) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = "Revoked."
                    self.person = User(key: "",secret: "",user: "",pass: "")
                } else {
                    self.failed()
                }
            })
            
        }
    }
    
    func pressAPI() {
        platform.api(person) { (bool: Bool, info: NSDictionary) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = info["apiVersions"]![0]["uriString"] as? String
                } else {
                    self.failed()
                }
            })
            
        }

    }
    
    func pressPresence() {
        platform.presence(person) { (bool: Bool, info: NSDictionary) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = info["presenceStatus"] as? String
                } else {
                    self.failed()
                }
            
            })
        }
    }
    
    func pressCallLog() {
        platform.callLog(person) { (bool: Bool, info: NSDictionary) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = String(info["records"]!.count)
                } else {
                    self.failed()
                }
                
            })
        }
    }
    
    func pressRingOutButton() {
        platform.ringOut(person, to: toBox.text!, from: fromBox.text!) { (bool: Bool) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = "called"
                } else {
                    self.failed()
                }
                
            })
        }
    }
    
    func pressSMSButton() {
        platform.SMS(person, msg: toBox.text!, to: toBox.text!) { (bool: Bool) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (bool) {
                    self.success()
                    self.text.text = "send"
                } else {
                    self.failed()
                }
                
            })
        }
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if (person.getAuth()) {
            if (sender === revokeButton) {
                pressRevoke()
            } else if (sender === presenceButton) {
                pressPresence()
            } else if (sender === callLogButton) {
                pressCallLog()
            } else if (sender === sendFaxButton) {
                
            } else if (sender === sendRingOutButton) {
                pressRingOutButton()
            } else if (sender === sendSMSButton) {
                pressSMSButton()
            } else if (sender === apiButton) {
                pressAPI()
            }
        } else {
            self.failed()
            self.text.text = "Invalid Authorization"
        }
    }
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        login()
        
        platform.authenticate(person, completion: { () -> Void in
            
            // learn what dispatch_sync and dispatch_async does
            // w/o either, it takes around 30 seconds to update
            // async returns in around 1 second, sync is almost instant
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                if (!self.person.getAuth()) {
                    self.failed()
                } else {
                    self.success()
                    self.text.text = self.person.getAccessToken()
                }
            })
            
        })
        
        self.view.endEditing(true)

    }
    
    // pressed "account info" button
    @IBAction func accountButtonPressed(sender: AnyObject) {
        if (person.getAuth() == true) {
            platform.getAccountInfo(person) { (input: NSDictionary) in
                dispatch_sync(dispatch_get_main_queue(), {() -> Void in
                self.text.text = "ID: " + String(input["id"] as! NSInteger) + " "
                    + "ext: " + (input["extensionNumber"] as! String)
                return
                })
            }
            success()
        } else {
            failed()
        }
    }
    
    // shows a "failed" status
    func failed() {
        status.text = "Failed."
        status.textColor = UIColor.redColor()
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("resetStatus"), userInfo: nil, repeats: false)
        self.text.text = "ERROR!"
    }
    
    // shows a "success" status
    func success() {
        status.text = "Success!"
        status.textColor = UIColor.blueColor()
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("resetStatus"), userInfo: nil, repeats: false)
    }
    
    // resets status back to gray
    func resetStatus() {
        self.status.text = "Status"
        self.status.textColor = UIColor.grayColor()
    }
    
    // overriding a method from above
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // override the view for self made functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons = [UIButton]()
        buttons.append(apiButton)
        buttons.append(accountButton)
        buttons.append(presenceButton)
        buttons.append(revokeButton)
        buttons.append(sendFaxButton)
        buttons.append(sendRingOutButton)
        buttons.append(sendSMSButton)
        buttons.append(callLogButton)
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.blackColor().CGColor
        
        
        status.layer.cornerRadius = 5
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor.blackColor().CGColor
        status.textColor = UIColor.grayColor()
        
        for button in buttons {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blackColor().CGColor
        }
        
        userBox.text = "13464448343"
        passBox.text = "P@ssw0rd"
        keyBox.text = "eI3RKs1oSBSY2kReFnviIw"
        secretBox.text = "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ"
        fromBox.text = "14088861168"
        toBox.text = "14088861168"
        messageBox.text = "hahaha"
        
        
        // testing out maps
        
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation = CLLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                
                currentLocation = locManager.location
                
        }
        
//        currentLocation = locManager.location
        
//        println(currentLocation.coordinate.longitude)
//        println(currentLocation.coordinate.latitude)
        
        var wrapper = SDKWrapper()
        wrapper.login(keyBox.text, secret: secretBox.text, user: userBox.text, pass: passBox.text) { (Bool) -> Void in
            println("inside: " + wrapper.isAuth().description)
            if (Bool) {
                println("Success!")
            } else {
                println("Error.")
            }
        }
        
        
        
        println("outside: " + wrapper.isAuth().description)

//        
//        
//        NSLog("testing")
    }
    
    
    
    
    
    

}

