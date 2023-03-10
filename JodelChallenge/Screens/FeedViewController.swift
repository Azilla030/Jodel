//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedViewController : UICollectionViewController {
    
    var photos : [URL] = []
    
    //var photos: FlickrImage = [FlickrImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        
//        FlickrApiSwift.fetchPhotos { photoURLs, error in
//            // Hier kannst du auf die zurückgegebenen Foto-URLs und Fehler zugreifen
//        }
        
        FlickrApiSwift.fetchPhotos { urls, error in // Ihr Code hier
//            self.photos = urls ?? []
//                DispatchQueue.main.async(execute: {
//                self?.collectionView?.reloadData()
//            })
            
            //print(urls)
        }
        
        
//        FlickrApi.fetchPhotos { [weak self] (responsePhotos, error) in
//            self?.photos = responsePhotos ?? []
//            DispatchQueue.main.async(execute: {
//                self?.collectionView?.reloadData()
//            })
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
}
