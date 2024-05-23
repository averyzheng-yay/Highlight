//
//  CollageView.swift
//  Highlight
//

import SwiftUI
import UIKit

struct ExportCollageView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    
    var body: some View {
        VStack {
            CollageView(viewModel: viewModel)
                .padding()
            Button(action: {
                exportCollageAsImage()
            }) {
                Text("Export Collage as JPG")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    private func exportCollageAsImage() {
        let collageImage = CollageView(viewModel: viewModel).asUIImage()
        
        if let imageURL = saveImageAsJPG(collageImage) {
            let activityViewController = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
            
            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                rootVC.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}

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
        
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 115, height: 115)
                    .clipped()
                    .cornerRadius(8)
            }
        }
    }
}

//#Preview {
//    CollageView()
//}
