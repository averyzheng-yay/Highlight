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

extension Array where Element: Entries {
    func groupedByDateAndLocation() -> [String: [Entries]] {
        var groupedEntries: [String: [Entries]] = [:]
        
        for entry in self {
            let date = DateFormatter.localizedString(from: entry.date, dateStyle: .short, timeStyle: .none)
            let location = entry.location != nil ? "\(entry.location!.coordinate.latitude),\(entry.location!.coordinate.longitude)" : "Unknown Location"
            let key = "\(date) - \(location)"
            
            if groupedEntries[key] == nil {
                groupedEntries[key] = []
            }
            groupedEntries[key]?.append(entry)
        }
        
        return groupedEntries
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
