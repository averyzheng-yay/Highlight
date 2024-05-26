//
//  ExportCollageView.swift
//  Highlight
//
//  Created by Student on 5/26/24.
//

import SwiftUI
import UIKit

struct ExportCollageView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    
    var body: some View {
        NavigationView {
                    CollageView(viewModel: viewModel)
                        .navigationTitle("Collage")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    exportCollageAsImage()
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            }
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
