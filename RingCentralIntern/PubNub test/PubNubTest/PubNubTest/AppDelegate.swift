//
//  AppDelegate.swift
//  PubNubTest
//
//  Created by Vincent Tseng on 7/15/15.
//  Copyright (c) 2015 Vincent Tseng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    var window: UIWindow?
    
    var client:PubNub?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let config = PNConfiguration( publishKey: "", subscribeKey: "sub-c-b8b9cd8c-e906-11e2-b383-02ee2ddab7fe")
        client = PubNub.clientWithConfiguration(config)
        client?.addListener(self)
        client?.subscribeToChannels(["33232195998092_690a3bc4"], withPresence: true)
        return true
    }

    func client(client: PubNub!, didReceiveStatus status: PNSubscribeStatus!) {
        println("status ANDREWJ ;LKAWJFE;LAKFJL JWEF")
        println(status.data)
    }
    
    func client(client: PubNub!, didReceivePresenceEvent event: PNPresenceEventResult!) {
        println("event ANDREW POSITIVITY ")
        println(event)
    }
    
    func client(client: PubNub!, didReceiveMessage message: PNMessageResult!, withStatus status: PNErrorStatus!) {
        println("message ANDREW ISGOOD")
        println(message)
        println(status)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    


}

