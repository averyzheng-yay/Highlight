//
//  CollageView.swift
//  Highlight
//

import SwiftUI
import UIKit

// Second tab view; displays a collage of the photos from the last 30 days
struct CollageTabView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.3, green: 0.5, blue: 1), Color(red: 0.678, green: 0.847, blue: 0.902)]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        Text("Last Month's Collage")
                            .customFont(.medium, 35)
                            .padding()
                    }
                }
                .frame(maxHeight: 100)
                
                VStack {
                    if viewModel.allPhotos.isEmpty {
                        VStack{
                            Text("No photos available")
                                .customFont(.light, 30)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    } else {
                        CollageView(entries: viewModel.entries)
                            .padding()
                    }
                }
                
                Button(action: {
                    exportCollageAsImage()
                }) {
                    Text("Export Collage")
                        .customFont(.regular, 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background((viewModel.allPhotos.isEmpty) ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(viewModel.allPhotos.isEmpty)
            }
        }
    }
    
    private func exportCollageAsImage() {
        let collageImage = CollageView(entries: viewModel.entries).asUIImage()
        
        if let imageURL = saveImageAsJPG(collageImage) {
            let activityViewController = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
            
            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                rootVC.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
}

// Actual grid-like collage layout view
struct CollageView: View {
    let entries: [Entries]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let totalEntries = entries.count
                let aspectRatios = entries.compactMap { entry -> CGFloat? in
                    if let photoEntry = entry as? PhotoEntries {
                        return photoEntry.image.size.width / photoEntry.image.size.height
                    }
                    return nil
                }
                let rows = Int(ceil(sqrt(Double(totalEntries) * 3 / 2)))
                let cols = Int(ceil(Double(totalEntries) / Double(rows)))
                
                let itemWidth = geometry.size.width / CGFloat(cols)
                let itemHeight = geometry.size.height / CGFloat(rows)
                
                ForEach(0..<entries.count, id: \.self) { index in
                    let row = index / cols
                    let col = index % cols
                    let xOffset = CGFloat(col) * itemWidth
                    let yOffset = CGFloat(row) * itemHeight
                    
                    if let photoEntry = entries[index] as? PhotoEntries {
                        let aspectRatio = aspectRatios[index]
                        if aspectRatio > 1 {
                            // Wider than tall
                            let width = itemWidth
                            let height = itemWidth / aspectRatio
                            Image(uiImage: photoEntry.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: width, height: height)
                                .position(x: xOffset + width / 2,
                                          y: yOffset + height / 2)
                                .offset(x: CGFloat.random(in: -10...10),
                                        y: CGFloat.random(in: -10...10))
                                .rotationEffect(.degrees(Double.random(in: -7...7)))
                            
                        } else {
                            // Taller than wide
                            let width = itemHeight * aspectRatio
                            let height = itemHeight
                            Image(uiImage: photoEntry.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: width, height: height)
                                .position(x: xOffset + width / 2,
                                          y: yOffset + height / 2)
                                .offset(x: CGFloat.random(in: -10...10),
                                        y: CGFloat.random(in: -10...10))
                                .rotationEffect(.degrees(Double.random(in: -7...7)))
                        }
                    } 
                }
            }
        }
        .frame(height: 450)
    }
}

//#Preview {
//    CollageView()
//}
