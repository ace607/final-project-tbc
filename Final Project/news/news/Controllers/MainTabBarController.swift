//
//  MainTabBarController.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let newTabBarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 6
        v.layer.shadowOpacity = 1
        return v
    }()
    
    override func loadView() {
        super.loadView()
        view.insertSubview(newTabBarView, belowSubview: tabBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
        NSLayoutConstraint.activate([
            newTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newTabBarView.topAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
        
        newTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let appearance = UITabBar.appearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.barTintColor = .clear
        appearance.tintColor = UIColor(red: 126/255, green: 93/255, blue: 252/255, alpha: 1.0)
        appearance.unselectedItemTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
    }
    
}
