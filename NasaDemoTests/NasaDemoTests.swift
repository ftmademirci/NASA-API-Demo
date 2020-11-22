//
//  NasaDemoTests.swift
//  NasaDemoTests
//
//  Created by Admin on 14.11.2020.
//

import XCTest
@testable import NasaDemo

class NasaDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "mock", withExtension: "json") else {
            XCTFail("Missing file: mocj.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()

        do {
            let photosResponse = try decoder.decode(PhotosResponse.self, from: json)
            
            XCTAssertEqual((photosResponse.photos![0].id), 102693)
            XCTAssertEqual((photosResponse.photos![0].earth_date), "2015-05-30")

            
        } catch {
            print(error.localizedDescription)
        }
    }
}
