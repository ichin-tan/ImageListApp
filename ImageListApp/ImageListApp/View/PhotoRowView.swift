//
//  PhotoRowView.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import SwiftUI

struct PhotoRowView: View {
    let author: String
    let url: String
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "photo")
                        .frame(width: 70, height: 70)
                        .background(Color.gray)
                        .cornerRadius(15)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .cornerRadius(15)
                    
                default:
                    Image(systemName: "photo")
                        .frame(width: 70, height: 70)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
            }
            
            Text(author)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(15)
        .background(Color.init("RowBackgroundColor"))
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white.opacity(0.01)))
    }
}
