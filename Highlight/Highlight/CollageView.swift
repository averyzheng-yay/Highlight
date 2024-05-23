//
//  CollageView.swift
//  Highlight
//

import SwiftUI

struct CollageView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel

    var body: some View {
        ScrollView {
            VStack {
                Text("Collage")
                    .customFont(.medium, 30)
                    .padding(.top, 20)
                if viewModel.allPhotos.isEmpty {
                    Text("No photos available")
                        .foregroundColor(.gray)
                } else {
                    CollageGridView(images: viewModel.allPhotos)
                        .padding()
                }
            }
        }
        .navigationTitle("Collage")
    }
}

struct CollageGridView: View {
    let images: [UIImage]

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(8)
            }
        }
    }
}

//#Preview {
//    CollageView()
//}
