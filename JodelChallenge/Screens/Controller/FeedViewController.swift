//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit
import SDWebImage

class FeedViewController : UICollectionViewController, UINavigationBarDelegate {
    
    var flickrPhotos: [FlickrImage] = []
    
    var loadingOverlay: LoadingOverlay?
    
    var isLoading = false // Keep track of whether the app is currently loading new photos
    
    let paginationView = PaginationView()
    
    var totalPages = 30
    
    var currentPage = 1 {
        didSet {
            paginationView.updateCurrentPageLabel(currentPage: currentPage)
        }
    }
    
    private let itemsPerPage = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        navigationController?.navigationBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        
        fetchFlickrPhotos()
        
    
        view.addSubview(paginationView)
        
        collectionView.addGestureRecognizer(longPressGesture)

        loadingOverlay = LoadingOverlay(frame: view.bounds)
        view.addSubview(loadingOverlay!)
        
        paginationView.previousButtonHandler = { [weak self] in
            guard let self = self else { return }
            if self.currentPage > 1 {
                self.currentPage -= 1
                self.fetchFlickrPhotos()
            }
        }

        paginationView.nextButtonHandler = { [weak self] in
            guard let self = self else { return }
            if self.currentPage < self.totalPages {
                self.currentPage += 1
                self.fetchFlickrPhotos()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        paginationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            paginationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paginationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paginationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            paginationView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loadingOverlay!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingOverlay!.topAnchor.constraint(equalTo: collectionView.topAnchor),
            loadingOverlay!.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            loadingOverlay!.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            loadingOverlay!.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrPhotos.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let photo = flickrPhotos[indexPath.row]
        cell.titleLabel.text = photo.title
        cell.imageView.sd_setImage(with: flickrPhotos[indexPath.row].url, placeholderImage: nil)
        
        // Add a tag to identify the cell's image view
        cell.imageView.tag = indexPath.row
        
        return cell
    }
    
    
    func fetchFlickrPhotos() {
        loadingOverlay?.isHidden = false
        FlickrApiSwift.shared.fetchPhotos(page: currentPage, perPage: itemsPerPage) { (photos, error) in
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
    
    @objc func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            // Anzeigen des Detail View Controllers
            let point = gestureRecognizer.location(in: self.collectionView)
            if let indexPath = self.collectionView.indexPathForItem(at: point) {
                let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                detailVC.selectedPhoto = flickrPhotos[indexPath.row]
                detailVC.modalPresentationStyle = .overFullScreen
                present(detailVC, animated: false, completion: nil)
            }
        } else if gestureRecognizer.state == .ended {
            // Ausblenden des Detail View Controllers
            dismiss(animated: false, completion: nil)
        }
    }
    
}

