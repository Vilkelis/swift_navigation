//
//  TabBarViewController.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 18.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    let feedNavigationController:UINavigationController = {
        let controller = UINavigationController()
        controller.title = "Feed"
        var image = UIImage(named: "house.fill")
        if #available(iOS 13.0, *) {
           image = UIImage(systemName: "house.fill")
        }
        controller.tabBarItem = UITabBarItem(title: "Feed", image: image, tag: 0)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "feedViewController") as! FeedViewController
        controller.viewControllers = [feedViewController]
        return controller
    }()
    
    let profileNavigationController:UINavigationController = {
        let controller = UINavigationController()
        controller.title = "Profile"        
        var image = UIImage(named:"person.fill")
        if #available(iOS 13.0, *) {
           image = UIImage(systemName: "person.fill")
        }
        controller.tabBarItem = UITabBarItem(title: "Profile", image: image, tag: 0)
        controller.viewControllers = [LogInViewController()]
        return controller
    }()
    
    lazy var mainTabBarController: UITabBarController = {
        let controller = UITabBarController()
        controller.viewControllers = [self.feedNavigationController, self.profileNavigationController]
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "appSystemBackground")
        self.view.addSubview(mainTabBarController.view)
    }
    
}
