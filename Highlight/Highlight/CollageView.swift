//
//  CollageView.swift
//  Highlight
//

import SwiftUI
import UIKit


struct CollageView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel

    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.3, green: 0.5, blue: 1), Color(red: 0.678, green: 0.847, blue: 0.902)]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        Text("Collage")
                            .customFont(.medium, 40)
                            .padding()
                    }
                }
                .frame(maxHeight: 100)
                
                ScrollView {
                    VStack {
                        if viewModel.allPhotos.isEmpty {
                            Text("No photos available")
                                .foregroundColor(.gray)
                        } else {
                            CollageGridView(images: viewModel.allPhotos)
                                .padding()
                        }
                    }
                }
            }
        }
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
