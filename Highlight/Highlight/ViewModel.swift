// PhotoJournalViewModel.swift

import SwiftUI

class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [Entries] = []
    
    func addEntry(title: String, image: UIImage) {
        let newEntry = PhotoEntries(title: title, image: image, date: Date())
        entries.append(newEntry)
    }
    
    func addEntry(title: String, text: String) {
        let newEntry = TextEntries(title: title, text: text, date: Date())
        entries.append(newEntry)
    }
}

