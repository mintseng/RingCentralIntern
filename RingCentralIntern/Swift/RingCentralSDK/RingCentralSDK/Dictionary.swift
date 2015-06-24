import Foundation

class Dictionary {
    
    let server: String
    
    init(server: String) {
        self.server = server
    }
    
    func getCountry(auth: Auth) {
        getCountry(auth, countryId: "1")
    }
    
    func getCountry(auth: Auth, countryId: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/country/" + countryId)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
//        println(response)
//        println(NSString(data: data!, encoding: NSUTF8StringEncoding))
    }
    
    func getCountries(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/dictionary/country/")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getState(auth: Auth) {
        getState(auth, stateId: "13")
    }
    
    func getState(auth: Auth, stateId: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/state/" + stateId)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getStates(auth: Auth) {
        getStates(auth, countryId: "1")
    }
    
    func getStates(auth: Auth, countryId: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/state?countryId=" + countryId)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getLocations(auth: Auth, stateId: String) {
        getLocations(auth, stateId: stateId, orderBy: "City")
    }
    
    func getLocations(auth: Auth, stateId: String, orderBy: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/location?stateId=" + stateId + "&orderBy=" + orderBy)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getTimezone(auth: Auth) {
        getTimezone(auth, zoneId: "1")
    }
    
    func getTimezone(auth: Auth, zoneId: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/timezone/" + zoneId)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getTimezones(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/dictionary/timezone")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getLanguage(auth: Auth) {
        getLanguage(auth, langId: "1033")
    }
    
    func getLanguage(auth: Auth, langId: String) {
        let url = NSURL(string: server + "/v1.0/dictionary/language/" + langId)
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
    func getLanguages(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/dictionary/language")
        
        // Sets up the request
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
    }
    
}