//
//  Constansts.swift
//  NasaDemo
//
//  Created by Admin on 14.11.2020.
//

import UIKit

struct Constants {
    
    static let baseUrl = "https://api.nasa.gov/mars-photos/api/v1"
    
    
    //The header fields
    enum HttpHeaderField: String {
        case contentType = "Content-Type"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }

}
