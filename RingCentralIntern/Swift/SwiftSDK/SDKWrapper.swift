import Foundation

/*
    A simple wrapper class designed for User usability.
 */

class SDKWrapper {
    
    // Platform for all the method calling.
    let platform = Platform()
    
    // User with which info will be filled into.
    var user = User()
    
    // Enters the credentials for the RingCentral User.
    func login(key: String, secret: String, user: String, pass: String, completion: (Bool) -> Void) -> Bool {
        
        // Sets the user credentials
        self.user.setKey(key)
        self.user.setSecret(secret)
        self.user.setUser(user)
        self.user.setPass(pass)
        
        self.platform.authenticate(self.user) {
            completion(self.user.getAuth())
        }
        
        return self.user.getAuth()
    }
    
    // Log RingCentral User out of services.
    func logout(person: User, completion: (Bool) -> Void) {
        self.platform.revoke(person) { (bool: Bool) -> Void in
            completion(bool)
        }
    }
    
    // Obtains the current version of the RingCentral API.
    func apiVersion(person: User) {
        
    }
    
    func isAuth() -> Bool {
        return user.getAuth()
    }
    
}


























