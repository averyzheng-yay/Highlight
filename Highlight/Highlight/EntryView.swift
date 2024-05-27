//
//  EntryView.swift - declaration of classes
//  Highlight
//

import SwiftUI

struct EntryView: View {
    var ent: Entries
    var body: some View {
        if let photoEntry = ent as? PhotoEntries {
            PhotoDetailView(photoEntry: photoEntry)
        } else {
            Text("Unknown entry type")
        }
    }
}

struct PhotoDetailView: View {
    var photoEntry: PhotoEntries

    var body: some View {
        VStack {
            Text(photoEntry.title)
                .font(.largeTitle)
            Text(photoEntry.date, style: .date)
                .font(.caption)
            Image(uiImage: photoEntry.image)
                .resizable()
                .scaledToFit()
            Text(photoEntry.text)
                .font(.body)
            if let location = photoEntry.location {
                Text("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                    .padding()
            } else {
                Text("Location: Unknown")
                    .padding()
            }
        }
        .padding()
    }
}


