import UIKit
import CryptoSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var base64Message = "PhgTtDVTaJ6Xb9hndZAk0BjGDHdjjrfuJnxgWyO+zFqsknHrwOwEK62Z/y5s3lsSJGoMZDZnY4Q56wGbWJM0c051mlevMdmsnzJEzL7CLKta327fImhnDyPeGbR41i//dbNOXOKhchSbS73pIAmHEUmlL1sNylYB8IyhyohjH5+av+NkvXm3Fjs9hfQqzaAyK75PKKlCtchZ4xTAohBLo9AxUVFzkRjde85h2QRc/8x7SXKxCODL3ZCJDc7aonbM+O+ojeMnbQTU4xC3aaqipkbsQhlW9YCqtn/kaHtHbYA="
        var base64Key = "rrnuxRyIrGBhyMI2fo12Ng=="
        
        println("NSSTRING")
        
        var byteMessage = [UInt8](base64Message.utf8)
        var byteKey = [UInt8](base64Key.utf8)
        
        var AESmessage = base64ToByteArray(base64Message)
        var AESkey = base64ToByteArray(base64Key)
        
        let key = AESkey
        let iv = Cipher.randomIV(AES.blockSize)
        
        let decrypted =  Cipher.AES(key: AESkey!, iv: iv, blockMode: .CBC).decrypt(AESmessage!)
        println(decrypted)
        println(String(stringInterpolationSegment: decrypted))
        
        
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let nsdata = NSData(base64EncodedString: base64String, options: nil) {
            var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
            nsdata.getBytes(&bytes)
            return bytes
        }
        return nil
    }
}

