//
//  PhotoItem.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

class PhotoItem: Codable, Identifiable {
    
    //MARK: - Properties
    
    let id: String
    let author: String
    let download_url: String
    var order: Int? = nil
}


