//
//  AppDelegate.swift
//  Supremo
//
//  Created by Sharad on 14/11/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootController()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedManager.saveContext()
    }
    
    //MARK:- Set Root Controller
    private func setRootController() {
        let splashScreenController                                   = HomeScreenController()
        let navigationController                                     = UINavigationController(rootViewController: splashScreenController)
        window                                                       = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController                                   = navigationController
        window?.makeKeyAndVisible()
    }
}

