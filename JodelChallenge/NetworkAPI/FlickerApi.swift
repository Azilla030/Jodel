//
//  FlickerApi.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 10.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import UIKit


class FlickrApiSwift {
    static func fetchPhotos(page: Int, perPage:Int,  completion: @escaping ([FlickrImage]?, Error?) -> Void) {
        let fk = FlickrKit.shared()
        fk.initialize(withAPIKey: "92111faaf0ac50706da05a1df2e85d82", sharedSecret: "89ded1035d7ceb3a")
        
        let interesting = FKFlickrInterestingnessGetList()
        interesting.per_page = "30"
        interesting.page = "\(page)"
        
        
        fk.call(interesting) { response, error in
            var photos: [FlickrImage]?
            if let response = response {
                photos = []
                if let photosDictionary = response as? [String: Any],
                   let photosArray = photosDictionary["photos"] as? [String: Any],
                   let photoDictionaries = photosArray["photo"] as? [[String: Any]] {
                    for photoData in photoDictionaries {
                        let photoURL = fk.photoURL(for: FKPhotoSize.small240, fromPhotoDictionary: photoData)
                        if let title = photoData["title"] as? String {
                            let image = FlickrImage(title: title, url: photoURL)
                            // Use the FlickrImage object as needed
                            photos?.append(image)
                            
                        }
                        
                        
                    }
                }
            }
            completion(photos, error)
            print(photos)
        }
    }
}
