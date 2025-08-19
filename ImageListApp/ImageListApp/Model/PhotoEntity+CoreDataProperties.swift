//
//  PhotoEntity+CoreDataProperties.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var author: String?
    @NSManaged public var download_url: String?

}

extension PhotoEntity : Identifiable {

}
