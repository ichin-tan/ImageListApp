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
            ApiManager.shared.fetchApiImages { result in
                switch result {
                case .success(let arrPhotos):
                    print(arrPhotos.first?.author)
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
