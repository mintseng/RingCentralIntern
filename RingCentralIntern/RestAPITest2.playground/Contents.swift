

// URL api call for getting token
let url = NSURL(string: "https://api.zoom.us/v1/user/getbyemail")

// Setting up User info for parsing
let bodyString = "email=michael.jchen04@gmail.com&" + "login_type=1"
let plainData = (key + ":" + secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

// Setting up HTTP request
let request = NSMutableURLRequest(URL: url!)
request.HTTPMethod = "GET"
request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")

// Sending HTTP request
var response: NSURLResponse?
var error: NSError?
let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)

if (response as! NSHTTPURLResponse).statusCode / 100 != 2 {
    return (data, response, error)
}

var errors: NSError?
let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary

request.resume()

println("hi")

XCPSetExecutionShouldContinueIndefinitely()