//
//  EntryView.swift
//  Highlight
//

import SwiftUI

struct EntryView: View {
    var ent: Entries
    var body: some View {
        if let photoEntry = ent as? PhotoEntries {
            PhotoDetailView(photoEntry: photoEntry)
        } else if let textEntry = ent as? TextEntries {
            TextDetailView(textEntry: textEntry)
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
        }
        .padding()
    }
}

struct TextDetailView: View {
    var textEntry: TextEntries

    var body: some View {
        VStack {
            Text(textEntry.title)
                .font(.largeTitle)
            Text(textEntry.date, style: .date)
                .font(.caption)
            Text(textEntry.text)
                .font(.body)
        }
        .padding()
    }
}
//#Preview {
//    EntryView()
//}
