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

// View that appears when entries are clicked into
struct PhotoDetailView: View {
    @State private var isEditing = false
    @ObservedObject var photoEntry: PhotoEntries
    
    var body: some View {
        VStack {
            Text(photoEntry.title)
                .customFont(.semiBold, 40)
            Image(uiImage: photoEntry.image)
                .resizable()
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            if let location = photoEntry.location {
                Text("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                    .customFont(.regular,20)
            } else {
                Text("Location: Unknown")
                    .customFont(.regular,20)
            }
            Text("Description:")
                .customFont(.regular,20)
            ScrollView{
                if photoEntry.text.isEmpty {
                    HStack{
                        Text("No Description Provided")
                            .customFont(.regular,20)
                            .padding(15)
                        Spacer()
                    }
                }
                else{
                    HStack{
                        Text(photoEntry.text)
                            .customFont(.regular,20)
                            .padding(15)
                        Spacer()
                    }
                }
            }
            .background(Color(.systemGray6))
            .frame(height: 220)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .padding()
        .navigationTitle("\(photoEntry.date)")
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

// View that appears when the entry needs to be edited
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
                // Image Picker unnecessary
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





