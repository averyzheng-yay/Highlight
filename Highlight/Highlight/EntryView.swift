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
    @State private var isEditing = false
    @ObservedObject var photoEntry: PhotoEntries

    var body: some View {
        VStack {
            Text(photoEntry.title)
                .font(.largeTitle)
            Text(photoEntry.date, style: .date)
                .font(.title)
            Image(uiImage: photoEntry.image)
                .resizable()
                .scaledToFit()
            if let location = photoEntry.location {
                Text("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                    .padding()
                    .font(.caption)
            } else {
                Text("Location: Unknown")
                    .padding()
                    .font(.caption)
            }
            Text(photoEntry.text)
                .font(.body)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            NavigationView {
                EditPhotoEntryView(photoEntry: photoEntry)
            }
        }
    }
}

struct EditPhotoEntryView: View {
    @ObservedObject var photoEntry: PhotoEntries
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $photoEntry.title)
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $photoEntry.text)
                    .frame(height: 100)
            }

            Section(header: Text("Image")) {
                // Implement image picker if needed
                Image(uiImage: photoEntry.image)
                    .resizable()
                    .scaledToFit()
            }
            
            Section(header: Text("Location")) {
                if let location = photoEntry.location {
                    Text("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                } else {
                    Text("Location: Unknown")
                }
            }
        }
        .navigationTitle("Edit Photo Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
        }
    }
}


