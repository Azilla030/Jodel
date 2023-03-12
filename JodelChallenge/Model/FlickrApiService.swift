//
//  FlickrApiService.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 12.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import Foundation


class FlickrApiService: FlickrAPI {
    let flickrKit: FlickrKit
    
    init() {
        flickrKit = FlickrKit.shared()
        flickrKit.initialize(withAPIKey: "92111faaf0ac50706da05a1df2e85d82", sharedSecret: "89ded1035d7ceb3a")
    }
    
    func fetchPhotos(page: Int, perPage: Int, completion: @escaping ([FlickrImage]?, Error?) -> Void) {
        let interesting = FKFlickrInterestingnessGetList()
        interesting.per_page = "\(perPage)"
        interesting.page = "\(page)"
        
        flickrKit.call(interesting) { response, error in
            guard let response = response,
                  let photosDictionary = response as? [String: Any],
                  let photosArray = photosDictionary["photos"] as? [String: Any],
                  let photoDictionaries = photosArray["photo"] as? [[String: Any]]
            else {
                completion(nil, error)
                return
            }
            
            let photos = photoDictionaries.compactMap { photoData -> FlickrImage? in
                guard let title = photoData["title"] as? String else {
                    return nil
                }
                let photoURL = self.flickrKit.photoURL(for: FKPhotoSize.small240, fromPhotoDictionary: photoData)
                return FlickrImage(title: title, url: photoURL)
                
            }
            
            completion(photos, error)
        }
    }
}
