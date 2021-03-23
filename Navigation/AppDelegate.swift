//
//  AppDelegate.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Закончили загрузку приложения
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("RUN: \(#function)")
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = TabBarViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
        
    // Становится не активным
    func applicationWillResignActive(_ application: UIApplication) {
        print("RUN: \(#function)")
    }
    
    // Перешли в бэкграунд
    // Тест на эмуляторе показал: Выполнялось все 174.97919690608978 секунд.
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("RUN: \(#function)")
        BackgroundTest().run()
    }
    
    // Выходим из бэкграунд
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("RUN: \(#function)")
    }
    
    // Приложение запущено и работает
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("RUN: \(#function)")
    }
    
    // Приложение будет прервано
    func applicationWillTerminate(_ application: UIApplication) {
        print("RUN: \(#function)" )
        print("Background time remaining = " +
            "\(UIApplication.shared.backgroundTimeRemaining) seconds")
    }
}
