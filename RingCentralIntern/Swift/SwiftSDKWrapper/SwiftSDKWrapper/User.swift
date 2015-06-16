import Foundation


// Mirrors an actual User using the platform.
// The idea is that only 1 user exists at a time accessing.
class User {
    var username: String
    var password: String
    var app_key: String
    var app_secret: String
    var access_token: String = ""
    var refresh_token: String = ""
    var authenticated: Bool = false

    
    init(key: String, secret: String, user: String, pass: String) {
        self.username   = user
        self.password   = pass
        self.app_key    = key
        self.app_secret = secret
    }
    
    init() {
        self.username   = ""
        self.password   = ""
        self.app_key    = ""
        self.app_secret = ""
    }
    
    // Sets the key of the user
    func setKey(token: String) {
        self.app_key = token
    }
    
    // Sets the secret of the user
    func setSecret(token: String) {
        self.app_secret = token
    }
    
    
    func setUser(token: String) {
        self.username = token
    }
    
    func setPass(token: String) {
        self.password = token
    }
    
    // Sets the access token
    func setAccessToken(token: String) {
        self.access_token = token
    }
    
    // Gets the access token
    func getAccessToken() -> String {
        return self.access_token
    }
    
    func getAuth() -> Bool {
        return self.authenticated
    }
    
    func setAuth(auth: Bool) {
        authenticated = auth
    }
    
    // Sets the refresh token
    func setRefreshToken(token: String) {
        self.refresh_token = token
    }
    
    // Gets the access token
    func getRefreshToken() -> String {
        return self.refresh_token
    }
    
    // Gets the username
    func getUsername() -> String {
        return self.username
    }
    
    // Some kind of time functionality is needed
}