//
//  PhotosViewModel.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import Foundation

class PhotosViewModel: ObservableObject {
    
    //MARK: - Properties -
    
    @Published var arrDbPhotos: [PhotoEntity] = []
    private var arrApiPhotos: [PhotoItem] = []
    @Published var isApiLoading: Bool = false
    @Published var isShowErrorAlert: Bool = false
    @Published var errMessage: String? = nil
    
    //MARK: - Initializer -
    
    init() {
        self.loadData()
    }
    
    //MARK: - Methods -
    
    private func loadData() {
        self.fetchSavedPhotosFromDB()
        self.fetchAllPhotosFromApi()
    }
    
    private func fetchAllPhotosFromApi() {
        self.isApiLoading = true
        ApiManager.shared.fetchPhotosAPI { result in
            self.isApiLoading = false
            switch result {
            case .success(let arrPhotos):
                self.arrApiPhotos = arrPhotos
            case .failure(let error):
                self.isShowErrorAlert = true
                self.errMessage = error.localizedDescription
            }
        }
    }
    
    private func fetchSavedPhotosFromDB() {
        self.arrDbPhotos = CoreDataManager.shared.getPhotos()
    }
    
    func addRandomPhotoToSavedPhotos() {
        guard let randomPhoto = self.arrApiPhotos.randomElement() else {
            if(self.arrApiPhotos.isEmpty) {
                self.fetchAllPhotosFromApi()
            }
            self.isShowErrorAlert = true
            self.errMessage = "There was some problem fetching the data from Api! Please try again."
            return
        }
        if(self.isAlreadyInSavedPhotos(photo: randomPhoto)) {
            if(self.arrDbPhotos.count >= self.arrApiPhotos.count) {
                self.isShowErrorAlert = true
                self.errMessage = "You have already saved all available photos!"
            } else {
                self.addRandomPhotoToSavedPhotos()
            }
        } else {
            randomPhoto.order = self.arrDbPhotos.count
            CoreDataManager.shared.add(photo: randomPhoto)
            self.fetchSavedPhotosFromDB()
        }
    }
    
    func deletePhotoFromSavedPhotos(photo: PhotoEntity) {
        CoreDataManager.shared.delete(photo: photo)
        self.fetchSavedPhotosFromDB()
    }
    
    func isAlreadyInSavedPhotos(photo: PhotoItem) -> Bool {
        return self.arrDbPhotos.contains(where: { $0.id == photo.id }) ? true : false
    }
    
    func reorderPhoto(from source: IndexSet, to destination: Int) {
        self.arrDbPhotos.move(fromOffsets: source, toOffset: destination)
        CoreDataManager.shared.updatePhotoOrder(photos: arrDbPhotos)
    }
}
