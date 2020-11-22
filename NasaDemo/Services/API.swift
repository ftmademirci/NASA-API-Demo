//
//  API.swift
//  NasaDemo
//
//  Created by Admin on 14.11.2020.
//

import Foundation
import Alamofire

typealias APICallback = (_ data: PhotosResponse?, _ error: String?) -> Void

protocol APIProvider {
    func getPhotos(roverType: String, cameraName: String?, page: Int, callback: @escaping APICallback)
}

class API: APIProvider {
    func getPhotos(roverType: String, cameraName: String?, page: Int, callback: @escaping APICallback) {
        AF.request(Router.getPhotos(roverType: roverType, cameraName: cameraName, page: page)).responseDecodable(of: PhotosResponse.self) { (response) in
            guard let photos = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(photos, nil)
        }
    }
}

