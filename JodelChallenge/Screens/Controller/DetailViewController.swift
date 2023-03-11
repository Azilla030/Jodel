//
//  DetailViewController.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 11.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    var selectedPhoto: FlickrImage?
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // Add the image view to the view controller's view
        view.addSubview(imageView)
        
        // Set the constraints for the image view to fill the view controller's view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let photo = selectedPhoto {
            imageView.sd_setImage(with: photo.url, placeholderImage: nil)
        }
    }

}
