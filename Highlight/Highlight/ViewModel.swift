// PhotoJournalViewModel.swift

import SwiftUI

class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [Entries] = []
    
    // will want to include a text element to photo entries as well
    func addEntry(title: String, image: UIImage) {
        let newEntry = PhotoEntries(title: title, image: image, date: Date())
        entries.append(newEntry)
    }
    
    //addEntry for separate type of entry - change later
    func addEntry(title: String, text: String) {
        let newEntry = TextEntries(title: title, text: text, date: Date())
        entries.append(newEntry)
    }
}

