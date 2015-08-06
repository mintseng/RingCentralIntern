//
//  main.swift
//  Crypt
//
//  Created by Vincent Tseng on 8/5/15.
//  Copyright (c) 2015 Vincent Tseng. All rights reserved.
//

import Foundation

println("Hello, World!")

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