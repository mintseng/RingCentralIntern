import Foundation

class Platform {
    
    let RINGCENTRAL = "https://platform.devtest.ringcentral.com/restapi"
    
    // attempts to log the user in
    func authenticate(person: User, completion: () -> Void) {
        
        // URL api call for getting token
        let url = NSURL(string: RINGCENTRAL + "/oauth/token")
        
        // Setting up User info for parsing
        let bodyString = "grant_type=password&" + "username=" + person.username + "&" + "password=" + person.password
        let plainData = (person.app_key + ":" + person.app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up HTTP request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
            } else {

                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    completion()
                    return
                }
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                
                person.setAuth(true)
                person.setAccessToken(readdata["access_token"] as! String)
                person.setRefreshToken(readdata["refresh_token"] as! String)
                completion()
            }
            
            
        }

        task.resume()
        
    }
    
    // retrieves the account information
    func getAccountInfo(person: User, completion: (input: NSDictionary) -> Void) {
        
        let url = NSURL(string: RINGCENTRAL + "/v1.0/account/~/extension/~")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
            } else {
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    println(response)
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    return
                }
                
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                completion(input: readdata)

            }
            
        }
        
        task.resume()
        
    }
    
    // revokes a token
    func revoke(person: User, completion: (bool: Bool) -> Void) {
        
        let url = NSURL(string: RINGCENTRAL + "/oauth/revoke")
        
        
        // Setting up User info for parsing
        let bodyString = "token=" + person.getAccessToken()
        let plainData = (person.app_key + ":" + person.app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                completion(bool: false)
            } else {
                completion(bool: true)
            }
        }
        
        task.resume()
        
        
    }
    
    // returns the API version
    func api(person: User, completion: (bool: Bool, info: NSDictionary) -> Void) {
        let url = NSURL(string: RINGCENTRAL + "/")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
            } else {
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    println(response)
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    return
                }
                
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                completion(bool: true, info: readdata)
                
            }
            
            
        }
        
        task.resume()
    }
    
    // returns the presence of calls
    func presence(person: User, completion: (bool: Bool, info: NSDictionary) -> Void) {
        let url = NSURL(string: RINGCENTRAL + "/v1.0/account/~/extension/~/presence")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
            } else {
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    println(response)
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    return
                }
                
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                completion(bool: true, info: readdata)
                
            }
            
            
        }
        
        task.resume()
        
    }
    
    // returns the call logs
    func callLog(person: User, completion: (bool: Bool, info: NSDictionary) -> Void) {
        let url = NSURL(string: RINGCENTRAL + "/v1.0/account/~/call-log")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
            } else {
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    println(response)
                    println(NSString(data: data, encoding: NSUTF8StringEncoding))
                    return
                }
                
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                completion(bool: true, info: readdata)
                
            }
            
            
        }
        
        task.resume()
    }
    
    func ringOut(person: User, to: String, from: String, completion: (bool: Bool) -> Void) {
        
        let url = NSURL(string: RINGCENTRAL + "/v1.0/account/~/extension/~/ringout")
        let number: String = person.getUsername()
        
        // Setting up User info for parsing
        let bodyString = "{" +
            "\"to\": {\"phoneNumber\": \"" +
            to +
            "\"}," +
            "\"from\": {\"phoneNumber\": \"" +
            from +
            "\"}," +
            "\"callerId\": {\"phoneNumber\": \"" +
            number +
            "\"}," +
            "\"playPrompt\": true" +
        "}"
        
        let plainData = (person.app_key + ":" + person.app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
//        var parameters = ["to": ["phoneNumber" : "14088861168"], "from" : ["phoneNumber" : "14088861168"], "callerId" : ["phoneNumber" : "1346448343"], "playPrompt" : "true" ]
//        
//        var err: NSError?
//        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err)
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
//            println(response)
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//            println(error)
            
            var errors: NSError?
            let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
            if error != nil {
                completion(bool: false)
            } else {
                completion(bool: true)
            }
            
            
        }
        
        task.resume()
    }
    
    // 15106907982
    
    func SMS(person: User, msg: String, to: String, completion: (bool: Bool) -> Void) {
        
        let url = NSURL(string: RINGCENTRAL + "/v1.0/account/~/extension/~/sms")
        
        // Setting up User info for parsing
        let number: String = person.getUsername()
        let bodyString = "{" +
            "\"to\": [{\"phoneNumber\": " +
            "\"" +
            to +
            "\"}]," +
            "\"from\": {\"phoneNumber\": \"" +
            number +
            "\"}," +
            "\"text\": \"" +
            msg +
            "\"" +
            "}"
        
        
        
        
        let plainData = (person.app_key + ":" + person.app_secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + person.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        //        var parameters = ["to": ["phoneNumber" : "14088861168"], "from" : ["phoneNumber" : "14088861168"], "callerId" : ["phoneNumber" : "1346448343"], "playPrompt" : "true" ]
        //
        //        var err: NSError?
        //        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err)
        
        // Sending HTTP request
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            println(response)
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            println(error)
            
            var errors: NSError?
            let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
            if error != nil {
                completion(bool: false)
            } else {
                completion(bool: true)
            }
            
            
        }
        
        task.resume()
    }
    
    
    
    
    
}