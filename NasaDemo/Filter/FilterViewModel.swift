//
//  FilterViewModel.swift
//  NasaDemo
//
//  Created by Admin on 19.11.2020.
//

import Foundation

class FilterViewModel {
    
    var roverType: RoverTypes?
    
    init(roverType: RoverTypes) {
        self.roverType = roverType
    }
    
    let curiosityCamera = ["FHAZ", "RHAZ", "MAST", "CHEMCAM", "MAHLI", "MARDI", "NAVCAM"]
    let spiritCamera = ["FHAZ", "RHAZ", "NAVCAM", "PANCAM", "MINITES"]
    let opportunityCamera = ["FHAZ", "RHAZ", "NAVCAM", "PANCAM", "MINITES"]
        
    func getCurrentCamera() -> [String]{
        switch roverType {
        case .curiosity:
            return self.curiosityCamera
        case .spirit:
            return self.spiritCamera
        case .opportunity:
            return self.opportunityCamera
        case .none:
            return []
        }
    }
    
    func getRowCount() -> Int {
        return self.getCurrentCamera().count
    }
    
    func getRow(_ index: Int) -> String {
        return self.getCurrentCamera()[index]
    }
}
