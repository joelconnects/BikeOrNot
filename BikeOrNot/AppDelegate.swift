//
//  AppDelegate.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/13/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LocationManagerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        LocationManager.shared.authorize()
        LocationManager.shared.locationManagerDelegate = self
        
        let mainViewController = MainViewController()
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        if let window = window {
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    func determinedInitialLocation(sender: LocationManager) {
        
        let darkSkyAPIManager = DarkSkyAPIManager()
        
        darkSkyAPIManager.getForecast(at: sender.location!) { (forecast, placemark) in
            
            switch forecast {
            case .success(let json):
                print(json!)
            case .failure(let error):
                print(error)
            }
            
            switch placemark {
            case .success(let placemark):
                print(placemark!)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

