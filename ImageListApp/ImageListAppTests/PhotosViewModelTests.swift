//
//  PhotosViewModelTests.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import XCTest
@testable import ImageListApp

final class PhotosViewModelTests: XCTestCase {
    
    var viewModel: PhotosViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = PhotosViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIsAlreadyInSavedPhotos() {
        let jsonString = """
        {
            "id": "100000",
            "author": "Test Author", 
            "download_url": "https://picsum.photos/200/300"
        }
        """

        let jsonData = jsonString.data(using: .utf8)!
        let testPhoto = try! JSONDecoder().decode(PhotoItem.self, from: jsonData)
        let result = viewModel.isAlreadyInSavedPhotos(photo: testPhoto)
        
        XCTAssertFalse(result, "Should return false for non existent photo")
    }
}
