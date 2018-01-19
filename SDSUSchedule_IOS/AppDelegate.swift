//
//  AppDelegate.swift
//  SDSUSchedule_IOS
//
//  Created by Anano on 13.01.18.
//  Copyright © 2018 SDSU. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        
        loadHTTPCookies()
        
        return true
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let content = notification.request.content
        print("\(content.userInfo)")
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().subscribe(toTopic: "/topics/administration")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveCookies()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        loadHTTPCookies()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveCookies()
    }
    
    func loadHTTPCookies() {
        
        if let cookieDict = UserDefaults.standard.value(forKey: "cookieArray") as? NSMutableArray {
            
            for c in cookieDict {
                
                let cookies = UserDefaults.standard.value(forKey: c as!String) as!NSDictionary
                let cookie = HTTPCookie(properties: cookies as![HTTPCookiePropertyKey: Any])
                
                HTTPCookieStorage.shared.setCookie(cookie!)
            }
        }
    }
    
    func saveCookies() {
        
        let cookieArray = NSMutableArray()
        if let savedC = HTTPCookieStorage.shared.cookies {
            for c: HTTPCookie in savedC {
                
                let cookieProps = NSMutableDictionary()
                cookieArray.add(c.name)
                cookieProps.setValue(c.name, forKey: HTTPCookiePropertyKey.name.rawValue)
                cookieProps.setValue(c.value, forKey: HTTPCookiePropertyKey.value.rawValue)
                cookieProps.setValue(c.domain, forKey: HTTPCookiePropertyKey.domain.rawValue)
                cookieProps.setValue(c.path, forKey: HTTPCookiePropertyKey.path.rawValue)
                cookieProps.setValue(c.version, forKey: HTTPCookiePropertyKey.version.rawValue)
                cookieProps.setValue(NSDate().addingTimeInterval(2629743), forKey: HTTPCookiePropertyKey.expires.rawValue)
                
                UserDefaults.standard.setValue(cookieProps, forKey: c.name)
                UserDefaults.standard.synchronize()
            }
        }
        
        UserDefaults.standard.setValue(cookieArray, forKey: "cookieArray")
    }
}
