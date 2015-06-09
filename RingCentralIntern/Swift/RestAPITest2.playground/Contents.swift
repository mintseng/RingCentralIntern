//: Playground - noun: a place where people can play

import Cocoa

import Foundation
import XCPlayground


// USER INPUT

let app_key = "eI3RKs1oSBSY2kReFnviIw"
let app_secret = "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ"
let username = "13464448343"
let password = "P@ssw0rd"

let RINGCENTRAL = "https://plaform.devtest.ringcentral.com/restapi"

let url = NSURL(string: "https://platform.devtest.ringcentral.com/restapi/oauth/token")
let request = NSMutableURLRequest(URL: url!)
request.HTTPMethod = "POST"


let plainData = (app_key + ":" + app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

let bodyString =
"grant_type=password&" +
    "username=" + username + "&" +
    "password=" + password

request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)

request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.setValue("application/json", forHTTPHeaderField: "Accept")

request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")


class User {
    var username: String
    var password: String
    var app_key: String
    var app_secret: String
    var access_token: String = ""
    
    init(key: String, secret: String, user: String, pass: String) {
        self.username   = user
        self.password   = pass
        self.app_key    = key
        self.app_secret = secret
    }
    
}



func authenticate(person: User) -> () {
    
    // URL api call for getting token
    let url = NSURL(string: RINGCENTRAL + "/oauth/token")
    
    // Setting up User info for parsing
    let bodyString = "grant_type=password&" + "username=" + person.username + "&" + "password=" + person.password
    let plainData = (person.app_key + ":" + person.app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
    let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    
    // Setting up HTTP request
    request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
    request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")
    
    // Sending HTTP request
    let task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        (data, response, error) in
        
        if error != nil {
            println("something went wrong")
        }
        println(data!)
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
        
        var errors: NSError?
        
        let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
        println(readdata["access_token"])
        person.access_token = readdata["access_token"] as! String
        
    }
    
    task.resume()
}

var person: User = User(key: app_key, secret: app_secret, user: username, pass: password)

authenticate(person)

person.access_token



//let task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//    (data, response, error) in
//    
//    if error != nil {
//        println("something went wrong")
//    }
//    println(data!)
//    println(NSString(data: data, encoding: NSUTF8StringEncoding))
//    
//    var errors: NSError?
//    
//    let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
//    println(readdata["access_token"])
//    accesstoken = readdata["access_token"] as! String
//    changeToken()
//    
//}
//
//println(accesstoken)
//
//task.resume()

// XCPSetExecutionShouldContinueIndefinitely()

//func HTTPsendRequest(request: NSMutableURLRequest,
//    callback: (String, String?) -> Void) {
//        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(
//            request,
//            completionHandler: {
//                data, response, error in
//                if error != nil {
//                    callback("", error.localizedDescription)
//                } else {
//                    callback(
//                        NSString(data: data, encoding: NSUTF8StringEncoding)! as String,
//                        nil
//                    )
//                }
//        })
//        
//        task2.resume()
//}
//func HTTPGet(url: String, callback: (String, String?) -> Void) {
//    var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//    HTTPsendRequest(request, callback)
//}
//
//
//
//HTTPGet("http://www.google.com") {
//    (data: String, error: String?) -> Void in
//    if error != nil {
//        println(error)
//    } else {
//        println(data)
//    }
//}


XCPSetExecutionShouldContinueIndefinitely()



