//
//  FlickerApi.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 10.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//

import UIKit


protocol FlickrAPI {
    func fetchPhotos(page: Int, perPage: Int, completion: @escaping ([FlickrImage]?, Error?) -> Void)
}
