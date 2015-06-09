//: Playground - noun: a place where people can play




import Foundation
import XCPlayground


let server = "https://platform.devtest.ringcentral.com/restapi"
var url: NSURL?
var request: NSMutableURLRequest
let authType = "Basic"

// USER INPUT

let app_key = "eI3RKs1oSBSY2kReFnviIw"
let app_secret = "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ"
let username = "13464448343"
let password = "P@ssw0rd"

let plainData = (app_key + ":" + app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
var access_token: String = ""
var refresh_token: String = ""

// user input


// AUTHORIZATION

url = NSURL(string: server + "/oauth/token/")

request = NSMutableURLRequest(URL: url!)

request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")


println(base64String)



// Convert app_secret and app_key to base64 encoding split by a ':'
request.addValue(authType + " " + base64String, forHTTPHeaderField: "Authorization")

request.HTTPMethod = "POST"
let bodyString =
    "grant_type=password&" +
    "username=" + username + "&" +
    "password=" + password

request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)

//let params:[String: String]
//= ["app_key": "eI3RKs1oSBSY2kReFnviIw",
//"app_secret": "Gv9DgBZVTkaQNbbyEx-SQQBsnUKECmT5GrmGXbHTmpUQ",
//"username": "13464448343",
//"grant_type": "password",
//"password": "P@ssw0rd"]
//
//var err: NSError?
//
//request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.allZeros, error: &err)

NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
    println(response)
    println(error)
    var errors: NSError?
    let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
    var keys: String = ""
    for (key, value) in readdata {
        keys += "\(key)" + " "
    }
    keys
    access_token = readdata["access_token"] as! String
    refresh_token = readdata["refresh_token"] as! String
}

// authorization


// REVOKE

//url = NSURL(string: server + "/oauth/revoke")
//
//request = NSMutableURLRequest(URL: url!)
//request.HTTPMethod = "POST"
//
//request.addValue(authType + " " + base64String, forHTTPHeaderField: "Authorization")
//
//let bodyString2 =
//    "token=" + access_token
//
//request.HTTPBody = bodyString2.dataUsingEncoding(NSUTF8StringEncoding)
//
//NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
//    println(NSString(data: data, encoding: NSUTF8StringEncoding))
//    println(response)
//    println(error)
//    println("End")
//}


// revoke



// API VERSION

url = NSURL(string: server + "/")

request = NSMutableURLRequest(URL: url!)
request.HTTPMethod = "GET"


NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
    println(response)
    println(error)
    println("End")
}

// api version


// ACCOUNT ID

url = NSURL(string: server + "/account/~/extension/~")

request = NSMutableURLRequest(URL: url!)
request.HTTPMethod = "GET"
request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
request.addValue("application/json", forHTTPHeaderField: "Accept")

NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
    println(response)
    println(error)
    println("End")
}


// account id


// XCPSetExecutionShouldContinueIndefinitely()
