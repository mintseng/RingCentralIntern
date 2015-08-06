import UIKit
import CryptoSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var message = "testing aes encryption and decryption"
        
        var test = 1
        
        switch test {
        case 1:
            var base64Message = "KZYKXfcEVjue35PXVPU9JnuwhTreM++EEwp7RqASET+oZeBjr7I/Zi4Cc92DT0FzN/Axtpg5ZTSrgnFikS04rdG6Lc6224y/LIFqjcxjpa48SllC8P7mMR3oXyRtUwz8SkyolRw+Fby7246rxzYAd/ufnej9NKvNhNaPntvfxASL6T7NuvNEVaIaQwQOh0ijeLKEYQzXY6mM/s3f6rQNTzDDKozRSF2gBH6q6e5w51iZWEA+7Tu0yQW3BBgosXg9MiuQjUzXqgVkx5+6eaAQb6aakLSWKCAlbis/Y6i25Ck="
//            base64Message = "TL2eBDRVD/yBmg+MkcvRsZeZhlOnGReFpdSGokOod2TcDVQMJCWedcsdxh3sX1cY"
            var base64Key = "EHfVV7NCJ2bDtN2gzY5ENA=="
            let key = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00] as [UInt8]
            
            let iv = Cipher.randomIV(AES.blockSize)
            
            // 3. decrypt with the same key and IV
//            let decrypted = AES(key: base64ToByteArray(base64Key), iv: [0x00], blockMode: .ECB)?.decrypt(base64ToByteArray(base64Message), padding: PKCS7())
            let decrypted = AES(key: base64ToByteArray(base64Key), iv: [0x00], blockMode: .ECB)?.decrypt(base64ToByteArray(base64Message), padding: PKCS7())
            var endMarker = NSData(bytes: (decrypted as [UInt8]!), length: decrypted!.count)
            
            // prints "5327f65a ff00f928 81c92434 0b8b4e0c 52"
            if let str: String = NSString(data: endMarker, encoding: NSUTF8StringEncoding) as? String  {
                println(str)
                println("success!")
            } else {
                println("no dice")
            }
        
        case 2:
            // 1. set key and random IV
            let key = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00] as [UInt8]
            let iv = Cipher.randomIV(AES.blockSize)
            
            // 2. encrypt
            let encrypted = Cipher.AES(key: key, iv: iv, blockMode: .ECB).encrypt(Array(message.utf8))
            //  let decrypted = Cipher.AES(key: AESkey, iv: [0x00], blockMode: .ECB).decrypt(AESmessage)
            
            
            // 3. decrypt with the same key and IV
            let decrypted = AES(key: key, iv: [0x01], blockMode: .ECB)?.decrypt(encrypted!, padding: PKCS7())
            
            var endMarker = NSData(bytes: (decrypted as [UInt8]!), length: decrypted!.count)
            
            // prints "74657374 696e6720 61657320 656e6372 79707469 6f6e2061 6e642064 65637279 7074696f 6e"
            if let str: String = NSString(data: endMarker, encoding: NSUTF8StringEncoding) as? String  {
                println(str)
            } else {
                println("no dice")
            }
            
        case 3:
            let key = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00] as [UInt8]
            let iv = Cipher.randomIV(AES.blockSize)

            // 2. encrypt
            let encrypted = Cipher.AES(key: key, iv: iv, blockMode: .ECB).encrypt(Array(message.utf8))
            //  let decrypted = Cipher.AES(key: AESkey, iv: [0x00], blockMode: .ECB).decrypt(AESmessage)
            
            var encodedMessage = byteArrayToBase64(encrypted!)
            println(encodedMessage)
            // 3. decrypt with the same key and IV
            let decrypted = AES(key: key, iv: [0x00], blockMode: .ECB)?.decrypt(base64ToByteArray(encodedMessage), padding: PKCS7())
            
            var endMarker = NSData(bytes: (decrypted as [UInt8]!), length: decrypted!.count)
            
            // prints "5327f65a ff00f928 81c92434 0b8b4e0c 52"
            if let str: String = NSString(data: endMarker, encoding: NSUTF8StringEncoding) as? String  {
                println(str)
            } else {
                println("no dice")
            }
            
        default:
            println("no test was chosen")
        }
        
        println("stop here")
        

        

        
//        var base64Message = "PhgTtDVTaJ6Xb9hndZAk0BjGDHdjjrfuJnxgWyO+zFqsknHrwOwEK62Z/y5s3lsSJGoMZDZnY4Q56wGbWJM0c051mlevMdmsnzJEzL7CLKta327fImhnDyPeGbR41i//dbNOXOKhchSbS73pIAmHEUmlL1sNylYB8IyhyohjH5+av+NkvXm3Fjs9hfQqzaAyK75PKKlCtchZ4xTAohBLo9AxUVFzkRjde85h2QRc/8x7SXKxCODL3ZCJDc7aonbM+O+ojeMnbQTU4xC3aaqipkbsQhlW9YCqtn/kaHtHbYA="
//        var base64Key = "rrnuxRyIrGBhyMI2fo12Ng=="
//        
//        var secretKey = "sec-c-ZDNlYjY0OWMtMWFmOC00OTg2LWJjMTMtYjBkMzgzOWRmMzUz"
//        
//        println("NSSTRING")
//        
//        var dataMsg = NSData.withBytes(base64ToByteArray(base64Message))
//        var dataKey = NSData.withBytes(base64ToByteArray(base64Key))
//        
//        var convertMsg = dataMsg.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.allZeros)
//        var convertKey = dataKey.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.allZeros)
//        
//        // converted base64 to hex
////        println(convertMsg)
////        println(convertKey)
//        
//        
//        var byteMessage = [UInt8](base64Message.utf8)
//        var byteKey = [UInt8](base64Key.utf8)
//        
//        
//        println("checkpoint")
//        
//        
//        var AESmessage = base64ToByteArray(base64Message)
//        var AESkey = base64ToByteArray(base64Key)
//        
//        let key = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00] as [UInt8]
//        let iv = Cipher.randomIV(AES.blockSize)
//        
//        let decrypted =  Cipher.AES(key: AESkey, iv: [0x00], blockMode: .ECB).decrypt(AESmessage)
//        
//        
//        
//        println("ended")
//        
//        let finalMessage = byteArrayToBase64(decrypted!)
//        
//        println("final message")
//        
//        println(finalMessage)
//        
//        
//        
//        let decodedData = NSData(base64EncodedString: finalMessage, options: NSDataBase64DecodingOptions(rawValue: 0))
//        println(decodedData)
//        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
//        println(decodedString)
//        
//        
//        println("the end point for the decryption")
        
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    
    
    func base64ToByteArray(base64String: String) -> [UInt8] {
        let nsdata: NSData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        // Create array of the required size ...
        var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
        // ... and fill it with the data
        nsdata.getBytes(&bytes)
        return bytes
    }
    
    func byteArrayToBase64(bytes: [UInt8]) -> String {
        let nsdata = NSData(bytes: bytes, length: bytes.count)
        let base64Encoded = nsdata.base64EncodedStringWithOptions(nil);
        return base64Encoded;
    }
    
    
}

