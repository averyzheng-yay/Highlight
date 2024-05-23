// PhotoJournalViewModel.swift

import SwiftUI

class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [Entries] = []
    
    func addEntry(title: String, image: UIImage, text: String) {
        let newEntry = PhotoEntries(title: title, image: image, text: text, date: Date())
        entries.append(newEntry)
    }
    
    func addEntry(title: String, text: String) {
        let newEntry = TextEntries(title: title, text: text, date: Date())
        entries.append(newEntry)
    }
    
    var allPhotos: [UIImage] {
            entries.compactMap { $0 as? PhotoEntries }.map { $0.image }
    }
}

