//
//  PhotoListView.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import SwiftUI

struct PhotoListView: View {
    
    @StateObject var viewModel = PhotosViewModel()
    @State private var photoToDelete: PhotoEntity?
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                if viewModel.arrDbPhotos.isEmpty {
                    VStack(spacing: 10) {
                        Text("No data available!")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.init("BackgroundColor"))
                    
                } else {
                    List {
                        ForEach(viewModel.arrDbPhotos) { photo in
                            PhotoRowView(author: photo.author ?? "Unknown", url: photo.download_url ?? "")
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.clear)
                                .padding(.vertical, 5)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        self.photoToDelete = photo
                                        showDeleteAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .background(Color.init("BackgroundColor"))
                    .listRowSeparator(.hidden)
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
                .background(viewModel.isApiLoading ? Color.gray.opacity(0.5) : Color.init("ButtonColor"))
                .foregroundColor(.white)
                .cornerRadius(15)
                .disabled(viewModel.isApiLoading)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(Color.init("BackgroundColor"))
            .navigationTitle("Saved Photos")
            .preferredColorScheme(.dark)
            .alert(isPresented: $viewModel.isShowErrorAlert) {
                Alert(title: Text("ImageListApp"), message: Text("\(self.viewModel.errMessage ?? "Some error occured!")"),dismissButton: .default(Text("OK"), action: {
                    print("Alert dismissed!")
                }))
            }
            .alert("Confirm Delete", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let photo = self.photoToDelete {
                        self.viewModel.deletePhotoFromSavedPhotos(photo: photo)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this favorite?")
            }
        }
    }
}

#Preview {
    PhotoListView()
}
