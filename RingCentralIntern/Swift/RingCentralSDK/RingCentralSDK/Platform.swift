import Foundation

class Platform {
    
    // Platform credentials
    var auth: Auth
    let server: String
    let appKey: String
    let appSecret: String
    
    
    /// Constructor for the platform of the SDK
    ///
    /// :param: appKey      The appKey of your app
    /// :param: appSecet    The appSecret of your app
    /// :param: server      Choice of PRODUCTION or SANDBOX
    init(appKey: String, appSecret: String, server: String) {
        self.appKey = appKey
        self.appSecret = appSecret
        self.server = server
    }
}