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
                            CollageGridView(groupedEntries: viewModel.entries.groupedByDateAndLocation())
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
    let groupedEntries: [String: [Entries]]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(groupedEntries.keys.sorted(), id: \.self) { key in
                    if let entries = groupedEntries[key] {
                        VStack(alignment: .leading) {
                            Text(key)
                                .font(.headline)
                                .padding([.leading, .trailing], 10)
                            ForEach(entries) { entry in
                                if let photoEntry = entry as? PhotoEntries {
                                    Image(uiImage: photoEntry.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                        .clipped()
                                        .cornerRadius(8)
                                        .padding([.leading, .trailing], 10)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CollageView()
//}
