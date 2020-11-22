//
//  Model.swift
//  NasaDemo
//
//  Created by Admin on 14.11.2020.
//

import Foundation

struct PhotosResponse: Codable {
    let photos: [Photo]?
   
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

struct Photo: Codable {
    public let id: Int?
    public let sol: Int?
    public let camera: Camera?
    public let img_src: String?
    public let earth_date: String?
    public let rover: Rover?
}

struct Camera: Codable {
    public let id: Int?
    public let name: String?
    public let rover_id: Int?
    public let full_name: String?
}

struct Rover: Codable {
    public let id: Int?
    public let name: String?
    public let landing_date: String?
    public let launch_date: String?
    public let status: String?
}

