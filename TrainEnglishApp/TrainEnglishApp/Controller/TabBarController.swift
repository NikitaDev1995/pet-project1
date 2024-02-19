//
//  TabBarController.swift
//  TrainEnglishApp
//
//  Created by Nikita Skripka on 18.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
    }
    
    private func configureTabBarController() {
        tabBar.items?[0].title = NSLocalizedString("TabBarController.BarItem[0].Title", comment: "")
        tabBar.items?[0].image = UIImage(systemName: "list.clipboard.fill")
        
        tabBar.items?[1].title = NSLocalizedString("TabBarController.BarItem[1].Title", comment: "")
        tabBar.items?[1].image = UIImage(systemName: "book.closed.fill")
    }
}
