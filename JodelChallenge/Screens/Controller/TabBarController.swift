//
//  TabBarController.swift
//  JodelChallenge
//
//  Created by Alexander - on 10.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import Foundation


import Foundation


class StartTabController: UITabBarController {
    
    var collectionViewController: UICollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout = UICollectionViewFlowLayout()
//        let collectionViewController = FeedViewController(collectionViewLayout: layout)
//
//
//
//        self.collectionViewController = collectionViewController
//        self.viewControllers = [collectionViewController]

        // Hintergrundfarbe der TabBar anpassen
        self.tabBar.barTintColor = UIColor.init(hex: "#ff8e00")
        
        // Textfarbe der TabBar-Elemente anpassen
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .normal)
        

        
        tabBarItem.title = ""
        
        tabBarItem.isEnabled = false
        
        if let index = tabBar.items?.firstIndex(of: tabBarItem) {
            tabBar.items?.remove(at: index)
        }

        // Eine benutzerdefinierte Ansicht mit Pfeilen und einem Label erstellen
        let customView = UIView()
        
        tabBar.addSubview(customView)
        
        let leftArrow = UIButton()
        leftArrow.setImage(UIImage(systemName: "arrow.left"), for:.normal)
        
        let rightArrow = UIButton()
        rightArrow.setImage(UIImage(systemName: "arrow.right"), for:.normal)
        
        let label = UILabel()
        //label.text = "Seite \(selectedIndex + 1)"
        
        customView.addSubview(leftArrow)
        customView.addSubview(rightArrow)
        customView.addSubview(label)
        
        
        customView.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              customView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
              customView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
              customView.topAnchor.constraint(equalTo: tabBar.topAnchor),
              customView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
          ])

          // Constraints für die Pfeil-Buttons und das Label festlegen
          leftArrow.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              leftArrow.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
              leftArrow.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
              leftArrow.widthAnchor.constraint(equalToConstant: 30),
              leftArrow.heightAnchor.constraint(equalToConstant: 30),
          ])
          
          rightArrow.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              rightArrow.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant:-10),
              rightArrow.centerYAnchor.constraint(equalTo:leftArrow.centerYAnchor),
              rightArrow.widthAnchor.constraint(equalTo:leftArrow.widthAnchor),
              rightArrow.heightAnchor.constraint(equalTo:leftArrow.heightAnchor)
          ])

       tabBar.addSubview(customView)
        
        
//        leftArrow.addTarget(self, action: #selector(collectionViewController.loadMorePhotos), for: .touchUpInside)
//        rightArrow.addTarget(self, action: #selector(collectionViewController.loadMorePhotos), for: .touchUpInside)
    }
    
    
}
