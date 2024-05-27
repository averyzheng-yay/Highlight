//
//  CollageView.swift
//  Highlight
//

import SwiftUI
import UIKit

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
                
                ScrollView {
                    VStack {
                        if viewModel.allPhotos.isEmpty {
                            VStack{
                                Spacer()
                                Text("No photos available")
                                    .customFont(.light, 30)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            CollageView(groupedEntries: viewModel.entries.groupedByDateAndLocation())
                                .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
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
        let collageImage = CollageView(groupedEntries: viewModel.entries.groupedByDateAndLocation()).asUIImage()
        
        if let imageURL = saveImageAsJPG(collageImage) {
            let activityViewController = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
            
            if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                rootVC.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
}

extension Array where Element: Entries {
    func groupedByDateAndLocation(fromLastMonth: Bool = true) -> [String: [Entries]] {
            var groupedEntries: [String: [Entries]] = [:]
            
            let calendar = Calendar.current
            let now = Date()
            let lastMonth = calendar.date(byAdding: .month, value: -1, to: now)!
            
            for entry in self {
                // Check if the entry is within the last month
                if !fromLastMonth || calendar.compare(entry.date, to: lastMonth, toGranularity: .month) == .orderedDescending {
                    let date = DateFormatter.localizedString(from: entry.date, dateStyle: .short, timeStyle: .none)
                    let location = entry.location != nil ? "\(entry.location!.coordinate.latitude),\(entry.location!.coordinate.longitude)" : "Unknown Location"
                    let key = "\(date) - \(location)"
                    
                    if groupedEntries[key] == nil {
                        groupedEntries[key] = []
                    }
                    groupedEntries[key]?.append(entry)
                }
            }
            
            return groupedEntries
        }
}

struct CollageView: View {
    let groupedEntries: [String: [Entries]]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(groupedEntries.keys.sorted(), id: \.self) { key in
                    if let entries = groupedEntries[key] {
                        VStack(alignment: .leading) {
                            CollageLayout(entries: entries)
                                .padding([.leading, .trailing], 10)
                        }
                    }
                }
            }
        }
    }
}

struct CollageLayout: View {
    let entries: [Entries]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let gridItems = Int(sqrt(Double(entries.count)).rounded(.up))
                let itemSize = CGSize(width: geometry.size.width / CGFloat(gridItems),
                                      height: geometry.size.height / CGFloat(gridItems))
                
                ForEach(0..<entries.count, id: \.self) { index in
                    let row = index / gridItems
                    let col = index % gridItems
                    let xOffset = CGFloat(col) * itemSize.width
                    let yOffset = CGFloat(row) * itemSize.height
                    
                    if let photoEntry = entries[index] as? PhotoEntries {
                        Image(uiImage: photoEntry.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemSize.width * 1.1, height: itemSize.height * 1.1)
                            .clipped()
                            .position(x: xOffset + itemSize.width / 2,
                                      y: yOffset + itemSize.height / 2)
                            .offset(x: CGFloat.random(in: -10...10),
                                    y: CGFloat.random(in: -10...10))
                            .rotationEffect(.degrees(Double.random(in: -7...7)))
                    } 
                }
            }
        }
        .frame(height: 300)
    }
}

//#Preview {
//    CollageView()
//}
