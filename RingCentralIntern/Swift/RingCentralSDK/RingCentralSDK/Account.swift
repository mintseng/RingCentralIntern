import Foundation

class Account {
    
    let server: String
    
    init(server: String) {
        self.server = server
    }
    
    func getAccountId(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data: NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
    }
    
    func getAccountIdExtensionId(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/extension/~")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data: NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
        
    }
    
    func getExtensions(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/extension")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data: NSData! = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errors) as! NSDictionary
        
        

    }
    
}