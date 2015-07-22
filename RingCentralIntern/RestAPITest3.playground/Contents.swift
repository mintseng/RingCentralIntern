import Foundation


var base64Key = "rrnuxRyIrGBhyMI2fo12Ng=="
var base64Message = "PhgTtDVTaJ6Xb9hndZAk0BjGDHdjjrfuJnxgWyO+zFqsknHrwOwEK62Z/y5s3lsSJGoMZDZnY4Q56wGbWJM0c051mlevMdmsnzJEzL7CLKta327fImhnDyPeGbR41i//dbNOXOKhchSbS73pIAmHEUmlL1sNylYB8IyhyohjH5+av+NkvXm3Fjs9hfQqzaAyK75PKKlCtchZ4xTAohBLo9AxUVFzkRjde85h2QRc/8x7SXKxCODL3ZCJDc7aonbM+O+ojeMnbQTU4xC3aaqipkbsQhlW9YCqtn/kaHtHbYA="

func base64ToByteArray(base64String: String) -> [UInt8]? {
    if let nsdata = NSData(base64EncodedString: base64String, options: nil) {
        var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
        nsdata.getBytes(&bytes)
        return bytes
    }
    return nil
}

var AESkey = base64ToByteArray(base64Key)
AESkey.0.dynamicType
var AESmessage = base64ToByteArray(base64Message)


var context = Swift.Dictionary<String, Any>()
context["method"] = "POST"
context["url"] = "/v1.0/account/~/extension/~/ringout"
context["body"] = ["to": ["phoneNumber": "14088861168"],
    "from": ["phoneNumber": "14088861168"],
    "callerId": ["phoneNumber": "13464448343"],
    "playPrompt": "true"]

context["body"]

var test = "hi"

var test2 = ["hi": "bye", "test": ["in": "out"]]
test2.description