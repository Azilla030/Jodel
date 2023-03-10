//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedViewController : UICollectionViewController {
    
    var flickrPhotos: [FlickrImage] = []
    
    var loadingOverlay: LoadingOverlay?
    
    var isLoading = false // Keep track of whether the app is currently loading new photos
    
    private var currentPage = 1
    private let itemsPerPage = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFlickrPhotos()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        
        
        let loadMoreButton = UIButton(type: .system)
        loadMoreButton.setTitle("\(currentPage)", for: .normal)
        loadMoreButton.addTarget(self, action: #selector(loadMorePhotos), for: .touchUpInside)
        collectionView.addSubview(loadMoreButton)
        
        // Create the loading overlay view and add it as a subview of the collection view
        loadingOverlay = LoadingOverlay(frame: view.bounds)
        view.addSubview(loadingOverlay!)
        loadingOverlay!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingOverlay!.topAnchor.constraint(equalTo: collectionView.topAnchor),
            loadingOverlay!.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            loadingOverlay!.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            loadingOverlay!.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])

        collectionView.addSubview(loadMoreButton)
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadMoreButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            loadMoreButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
        
        
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadMoreButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            loadMoreButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Position the loading overlay in the center of the collection view
        loadingOverlay?.center = collectionView.center
    }
    
    
    func fetchFlickrPhotos() {
        loadingOverlay?.isHidden = false
        FlickrApiSwift.fetchPhotos(page: currentPage, perPage: itemsPerPage) { (photos, error) in
            if let photos = photos {
                self.flickrPhotos.removeAll() // Leere das Array, bevor du neue Fotos hinzufügst
                self.flickrPhotos = photos
                DispatchQueue.main.async {
                    self.loadingOverlay?.isHidden = true
                    self.collectionView.reloadData()
                }
            } else {
                print("Error fetching Flickr photos: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    @objc func loadMorePhotos() {
        currentPage += 1
        fetchFlickrPhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrPhotos.count
    }
    
    
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let photo = flickrPhotos[indexPath.row]
        cell.titleLabel.text = photo.title
        cell.configure(with: flickrPhotos[indexPath.row].url)
        
        return cell
    }
    
    
}
