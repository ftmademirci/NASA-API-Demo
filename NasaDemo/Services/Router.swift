//
//  Router.swift
//  NasaDemo
//
//  Created by Admin on 15.11.2020.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case getPhotos(roverType: String, cameraName: String?, page: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let newURLRequest = urlRequest.description.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let convertedURL = URL(string: newURLRequest!)
        urlRequest = URLRequest(url: convertedURL!)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPhotos(let roverType, let cameraName, let page):
            return "/rovers/\(roverType)/photos?sol=1000&api_key=DEMO_KEY&page=\(page)" + (cameraName != nil ? "&camera=\(cameraName ?? "")" : "")
        }
    }
    
}
