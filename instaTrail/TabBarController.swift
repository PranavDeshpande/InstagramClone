//
//  TabBarController.swift
//  instaTrail
//
//  Created by Pritesh Parekh on 8/1/17.
//  Copyright © 2017 Pritesh Parekh. All rights reserved.
//

import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let newsFeed = ViewController(collectionViewLayout : layout)
        let homeController = UINavigationController(rootViewController: newsFeed)
        homeController.tabBarItem.title = "Home"
        
        
            
        
        
        
    }
    
    
    
    
    
}
