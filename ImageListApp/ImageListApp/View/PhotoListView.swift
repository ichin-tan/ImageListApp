//
//  PhotoListView.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import SwiftUI

struct PhotoListView: View {
    
    @StateObject var viewModel = PhotosViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                if viewModel.arrDbPhotos.isEmpty {
                    VStack(spacing: 12) {
                        Text("No data available!")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.09))
                    
                } else {
                    List {
                        ForEach(viewModel.arrDbPhotos) { photo in
                            Text(photo.author ?? "")
                                .listRowBackground(Color(red: 0.08, green: 0.08, blue: 0.09))
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color(red: 0.08, green: 0.08, blue: 0.09))
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                }
                
                Button {
                    viewModel.addRandomPhotoToSavedPhotos()
                } label: {
                    if viewModel.isApiLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)

                    } else {
                        Text("Add Photo")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 15)
                .background(viewModel.isApiLoading ? Color.gray.opacity(0.5) : Color(red: 0.18, green: 0.45, blue: 0.97))
                .foregroundColor(.white)
                .cornerRadius(15)
                .disabled(viewModel.isApiLoading)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(Color(red: 0.08, green: 0.08, blue: 0.09))
            .navigationTitle("Saved Photos")
            .preferredColorScheme(.dark)
            .alert(isPresented: $viewModel.isShowErrorAlert) {
                Alert(title: Text("ImageListApp"), message: Text("\(self.viewModel.errMessage ?? "Some error occured!")"),dismissButton: .default(Text("OK"), action: {
                    print("Alert dismissed!")
                }))
            }
        }
    }
}

#Preview {
    PhotoListView()
}
