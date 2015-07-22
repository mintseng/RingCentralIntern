import UIKit
import PubNub
import CryptoSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    var window: UIWindow?
    
    var client:PubNub?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let config = PNConfiguration( publishKey: "", subscribeKey: "sub-c-b8b9cd8c-e906-11e2-b383-02ee2ddab7fe")
        client = PubNub.clientWithConfiguration(config)
        client?.addListener(self)
        client?.subscribeToChannels(["398868478581806_48b4d23e"], withPresence: true)
        return true
    }
    
    func client(client: PubNub!, didReceiveMessage message: PNMessageResult!) {
        var base64Message = message.data.message as! String
        var base64Key = "y0wtfFiGOXwMxmv5p7yrAw=="
        
        var AESmessage = base64ToByteArray(base64Message)
        var AESkey = base64ToByteArray(base64Key)
        
        let key = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00] as [UInt8]
        let iv = Cipher.randomIV(AES.blockSize)
        
        let decrypted = AES(key: AESkey!, iv: iv, blockMode: .CBC)?.decrypt(AESmessage!, padding: PKCS7())
        println(decrypted)
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let nsdata = NSData(base64EncodedString: base64String, options: nil) {
            var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
            nsdata.getBytes(&bytes)
            return bytes
        }
        return nil
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
}

