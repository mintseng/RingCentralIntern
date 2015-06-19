import Foundation

/// Object representation of a Standard Development Kit for RingCentral
class Sdk {
    
    
    // Set constants for SANDBOX and PRODUCTION servers.
    static var RC_SERVER_PRODUCTION: String = "https://plaform.ringcentral.com/restapi"
    static var RC_SERVER_SANDBOX: String = "https://plaform.devtest.ringcentral.com/restapi"
    
    // Platform variable, version, and current Subscriptions
    var platform: Platform
    var subscription: Subscription?
    
    
    /// Constructor for making the SDK object.
    ///
    /// Example:
    ///
    ///     init(appKey, appSecret, Sdk.RC_SERVER_PRODUCTION)
    /// or
    ///
    ///     init(appKey, appSecret, Sdk.RC_SERVER_SANDBOX)
    /// 
    /// :param: appKey      The appKey of your app
    /// :param: appSecet    The appSecret of your app
    /// :param: server      Choice of PRODUCTION or SANDBOX
    init(appKey: String, appSecret: String, server: String) {
        platform = Platform(appKey: appKey, appSecret: appSecret, server: server)
    }
    
    
    /// Returns the Platform with the specified appKey and appSecret.
    ///
    /// :returns: A Platform to access the methods of the SDK
    func getPlatform() -> Platform {
        return self.platform
    }
    
    /// Returns the current Subscription.
    ///
    /// :returns: A Subscription that the user is currently following
    func getSubscription() -> Subscription? {
        return self.subscription
    }
    
    
    
}