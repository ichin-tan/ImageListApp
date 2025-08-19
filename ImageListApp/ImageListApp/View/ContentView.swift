//
//  ContentView.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Text("Loadded")
        }
        .onAppear() {
            ApiManager.shared.fetchPhotosAPI { result in
                switch result {
                case .success(let arrPhotos):
                    print(arrPhotos.first?.author)
                    // Test Core data
                    
                    if let photo = arrPhotos.first {
                        CoreDataManager.shared.addPhoto(photo: photo)
                        print(CoreDataManager.shared.getPhotos().count)
                        print(CoreDataManager.shared.getPhotos().first?.author)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
