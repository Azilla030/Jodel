//
//  CollectionViewControllerGestureHandler.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 12.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import UIKit
import Foundation

class LongPressHandler {
    weak var collectionView: UICollectionView?
    weak var viewController: UIViewController?
    var flickrPhotos: [FlickrImage]

    init(collectionView: UICollectionView, viewController: UIViewController, flickrPhotos: [FlickrImage]) {
        self.collectionView = collectionView
        self.viewController = viewController
        self.flickrPhotos = flickrPhotos
    }
    
    
    func updateFlickrPhotos(_ newPhotos: [FlickrImage]) {
        self.flickrPhotos = newPhotos
    }
    

    @objc func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Anzeigen des Detail View Controllers
            let point = gestureRecognizer.location(in: collectionView)
            if let indexPath = collectionView?.indexPathForItem(at: point),
               indexPath.row < flickrPhotos.count {
                let detailVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                detailVC.selectedPhoto = flickrPhotos[indexPath.row]
                detailVC.modalPresentationStyle = .overFullScreen
                viewController?.present(detailVC, animated: false, completion: nil)
            }
        } else if gestureRecognizer.state == .ended {
            // Ausblenden des Detail View Controllers
            viewController?.dismiss(animated: false, completion: nil)
        }
    }
}
