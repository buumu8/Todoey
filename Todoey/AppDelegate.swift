//
//  AppDelegate.swift
//  Todoey
//
//  Created by Jettapol Tuetrakul on 21/9/2561 BE.
//  Copyright © 2561 Jettapol Tuetrakul. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        }
        catch {
            print("error initialising new realm : \(error)")
        }
        
        
        return true
    }

}

