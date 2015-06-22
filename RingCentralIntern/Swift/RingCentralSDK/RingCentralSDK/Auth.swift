import Foundation

/// Authorization object for the platform.
class Auth {
    
    static let MAINCOMPANY = "101"
    
    // Authorization information
    var access_token: String?
    var expires_in: Double = 0
    var expire_time: Double = 0
    
    var app_key: String?
    var app_secret: String?
    
    var refresh_token: String?
    var refresh_token_expires_in: Double = 0
    var refresh_token_expire_time: Double = 0
    
    var token_type: String?
    var scope: String?
    var owner_id: String?
    
    let username: String
    let password: String
    let ext: String
    let server: String
    
    var authenticated: Bool = false
    var updating: Bool = false
    
    
    /// Constructor for authorization for the platform
    ///
    /// :param: username RingCentral phone number
    /// :param: password Password to the RingCentral account
    convenience init(username: String, password: String, server: String) {
        self.init(username: username, ext: Auth.MAINCOMPANY, password: password, server: server)
    }
    
    
    /// Constructor for authorization for the platform with extension
    ///
    /// :param: username RingCentral phone number
    /// :param: password Password to the RingCentral account
    init(username: String, ext: String, password: String, server: String) {
        self.server = server
        self.username = username
        self.password = password
        self.ext = ext
    }
    
    // PROBLEM: cannot get "scope" to work as inteded according to API
    //          does not work on API explorer either
    
    /// Logs the user in with the current credentials.
    ///
    /// :param: key The appKey for RC account
    /// :param: secret The appSecret for RC account
    func login(key: String, secret: String) {
        self.app_key = key
        self.app_secret = secret
        
        // URL api call for getting token
        let url = NSURL(string: server + "/oauth/token")
        
        // Setting up User info for parsing
        let bodyString = "grant_type=password&" + "username=" + self.username + "&" + "password=" + self.password + "&" + "extension=" + self.ext
        let plainData = (key + ":" + secret as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up HTTP request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        self.updating = true
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                self.updating = false
                println(error)
            } else {
                
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    self.updating = false
                    return
                }
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                
                // Setting authentication information
                self.authenticated = true
                self.access_token = readdata["access_token"] as? String
                self.expires_in = readdata["expires_in"] as! Double
                
                self.refresh_token = readdata["refresh_token"] as? String
                self.refresh_token_expires_in = readdata["refresh_token_expires_in"] as! Double
                
                self.token_type = readdata["token_type"] as? String
                self.scope = readdata["scope"] as? String
                self.owner_id = readdata["owner_id"] as? String
                
                let time = NSDate().timeIntervalSince1970
                
                self.expire_time = time + self.expires_in
                self.refresh_token_expire_time = time + self.refresh_token_expires_in
                
                self.updating = false
            }
            
            
        }
        
        task.resume()
    }
    
    /// Refreshes the access_token and refresh_token with the current refresh_token
    ///
    ///
    func refresh() {
        // URL api call for getting token
        let url = NSURL(string: server + "/oauth/token")
        
        // Setting up User info for parsing
        var bodyString = "grant_type=refresh_token&" + "username=" + self.username + "&" + "password=" + self.password + "&" + "extension=" + self.ext + "&" + "refresh_token=" + self.refresh_token!
        let plainData = (self.app_key! + ":" + self.app_secret! as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        // Setting up HTTP request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic" + " " + base64String, forHTTPHeaderField: "Authorization")
        
        // Sending HTTP request
        self.updating = true
        var task: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if error != nil {
                println(error)
                self.updating = false
            } else {
                
                if ((response as! NSHTTPURLResponse).statusCode / 100 != 2) {
                    self.updating = false
                    return
                }
                var errors: NSError?
                let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
                
                // Setting authentication information
                self.authenticated = true
                self.access_token = readdata["access_token"] as? String
                self.expires_in = readdata["expires_in"] as! Double
                
                self.refresh_token = readdata["refresh_token"] as? String
                self.refresh_token_expires_in = readdata["refresh_token_expires_in"] as! Double
                
                self.token_type = readdata["token_type"] as? String
                self.scope = readdata["scope"] as? String
                self.owner_id = readdata["owner_id"] as? String
                
                let time = NSDate().timeIntervalSince1970
                
                self.expire_time = time + self.expires_in
                self.refresh_token_expire_time = time + self.refresh_token_expires_in
                
                self.updating = false
            }
            
            
        }
        
        task.resume()
    }
    
    /// Checks if the access_token needs to be refreshed
    ///
    ///
    func update() -> Bool {
        let time = NSDate().timeIntervalSince1970
        if (time < refresh_token_expire_time) {
            if (!(time < self.expire_time)) {
                refresh()
            }
            return true
        } else {
            return false
        }
        
    }
    
    /// Checks whether or not the access token is valid
    /// 
    /// :returns: A boolean for validity of access token
    func isAccessTokenValid() -> Bool {
        return false
    }
    
    /// Checks for the validity of the refresh token
    /// 
    /// :returns: A boolean for validity of the refresh token
    func isRefreshTokenVald() -> Bool {
        return false
    }
    
    /// Checks if Auth is currently updating
    ///
    /// :returns: A boolean for if Auth is currently updating
    func isUpdating() -> Bool {
        return self.updating
    }
    
    /// Revokes the access_token
    ///
    ///
    func revokeAccessToken() {
        let url = NSURL(string: server + "/oauth/revoke")
        
        
        // Setting up User info for parsing
        let bodyString = "token=" + access_token!
        let plainData = (app_key! + ":" + app_secret! as NSString).dataUsingEncoding(NSUTF8StringEncoding)
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
            println(response)
        }
        
        task.resume()
    }
    
    
    /// Revokes the refresh_token
    ///
    /// 
    func revokeRefreshToken() {
        let url = NSURL(string: server + "/oauth/revoke")
        
        // Setting up User info for parsing
        let bodyString = "token=" + refresh_token!
        let plainData = (app_key! + ":" + app_secret! as NSString).dataUsingEncoding(NSUTF8StringEncoding)
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
            println(response)
        }
        task.resume()
    }
    
    
    
}