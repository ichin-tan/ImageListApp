//
//  CoreDataManager.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import CoreData

class CoreDataManager {
    
    //MARK: - Properties -
    
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
        
    //MARK: - Initializer -
    
    private init() {
        container = NSPersistentContainer(name: "ImageListApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("A problem occured setting up core data! - \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Methods -
    
    private func saveDB() {
        if(self.context.hasChanges) {
            try? self.context.save()
        }
    }
    
    func getPhotos() -> [PhotoEntity] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PHOTO_ENTITY)
        let arrPhotos = try? self.context.fetch(fetchRequest) as? [PhotoEntity]
        return arrPhotos ?? []
    }
    
    func addPhoto(photo: PhotoItem) {
        let photoEntity = PhotoEntity(context: self.context)
        photoEntity.id = photo.id
        photoEntity.author = photo.author
        photoEntity.download_url = photo.download_url
        self.saveDB()
    }
}
