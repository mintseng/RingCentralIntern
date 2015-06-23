import Foundation

class CallLog {

    var server: String
    
    init(server: String) {
        self.server = server
    }
    
    func callLog(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/call-log")
        httpRequest(auth, url: url!)
    }
    
    func httpRequest(auth: Auth, url: NSURL) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer" + " " + auth.getAccessToken(), forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?
        var error: NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        var errors: NSError?
        let readdata = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary
        
        println((response as! NSHTTPURLResponse).statusCode)
//        println(response)
//        println(NSString(data: data!, encoding: NSUTF8StringEncoding))
//        println(error)
    }
    
    func callRecordIds(auth: Auth, id: String) {
        let url = NSURL(string: server + "/v1.0/account/~/call-log/" + id)
        httpRequest(auth, url: url!)
    }
    
    func callRecordIdsExt(auth: Auth, id: String) {
        let url = NSURL(string: server + "/v1.0/account/~/extension/~/call-log/" + id)
        httpRequest(auth, url: url!)
    }
    
    func callLogExt(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/extension/~/call-log")
        httpRequest(auth, url: url!)
    }
    
    func activeCalls(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/active-calls")
        httpRequest(auth, url: url!)
    }
    
    func activeCallsExt(auth: Auth) {
        let url = NSURL(string: server + "/v1.0/account/~/extension/~/active-calls")
        httpRequest(auth, url: url!)
    }
}