import Foundation

var RCSDK = SDKWrapper()

// Variables for testing purposes
var app_key = "eI3RKs1oSBSY2kReFnviIw"
var app_secret = "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ"
var username = "13464448343"
var password = "P@ssw0rd"

RCSDK.login(app_key, secret: app_secret, user: username, pass: password) {
    (databack, error) in
    
    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
        if let check = error {
            println(error)
        } else {
            println(databack)
        }
    })
    
    
}

