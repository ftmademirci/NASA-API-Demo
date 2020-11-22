//
//  MainViewModel.swift
//  NasaDemo
//
//  Created by Admin on 21.11.2020.
//

import Foundation

class MainViewModel {
    
    var api: API!
    var roverType: RoverTypes!
    
    var photos: [Photo]?
    
    var cameraName: String!
    
    var page = 1
    var endOfPage = false
    var perPage = 25
    
    init(api: API, roverType: RoverTypes) {
        self.api = api
        self.roverType = roverType
    }
    
    func fetchPhotos(success: @escaping() -> Void,
                          failure: @escaping (String?) -> Void) {
        self.api.getPhotos(roverType: "\(roverType.rawValue)", cameraName: self.cameraName, page: self.page) { [self] (response, error) in
            if error != nil {
                failure("error on loading photos")
            } else {
                if let photos_list = response?.photos {
                    
                    if page == 1 {
                        self.photos = photos_list
                    } else {
                        self.photos?.append(contentsOf: photos_list)
                    }
                    self.page = self.page + 1
                    
                    if photos_list.count == 0 || photos_list.count < perPage {
                        self.endOfPage = true
                    }
                    
                    success()
                } else {
                    failure("error on loading photos")
                }
            }
        }
    }
    
    func resetPagination() {
        self.page = 1
        self.endOfPage = false
    }
    
    func getNextPage(_ index: Int) -> Bool {
        if self.photos != nil && index == self.photos!.count - 3 && !endOfPage {
            return true
        } else {
            return false
        }
    }
    
    func getRowCount() -> Int {
        return (self.photos != nil ? self.photos!.count : 0)
    }
    
    func getRow(_ index: Int) -> Photo? {
        if let dataArray = self.photos {
            return dataArray[index]
        }
        
        return nil
    }
    
}
