import Foundation

/// Authorization object for the platform.
class Auth {
    
    static let EMPTYSTRING = ""
    
    // Authorization information
    var access_token: String?
    var expires_in: Double?
    var expire_time: Double?
    
    var refresh_token: String?
    var refresh_token_expires_in: Double?
    var refresh_token_expire_time: Double?
    
    var scope: String?
    var owner_id: String?
    
    let username: String
    let password: String
    let ext: String
    
    
    /// Constructor for authorization for the platform
    ///
    /// :param: username RingCentral phone number
    /// :param: password Password to the RingCentral account
    convenience init(username: String, password: String) {
        self.init(username: username, ext: Auth.EMPTYSTRING, password: password)
    }
    
    
    /// Constructor for authorization for the platform with extension
    ///
    /// :param: username RingCentral phone number
    /// :param: password Password to the RingCentral account
    init(username: String, ext: String, password: String) {
        self.username = username
        self.password = password
        self.ext = ext
    }
    
    
    /// Logs the user in with the current credentials.
    ///
    /// :param: key The appKey for RC account
    /// :param: secret The appSecret for RC account
    func login(key: String, secret: String) {
        
        
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
    
}