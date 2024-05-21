// PhotoJournalViewModel.swift

import SwiftUI

class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [PhotoEntry] = []
    
    func addEntry(title: String, image: UIImage) {
        let newEntry = PhotoEntry(title: title, image: image, date: Date())
        entries.append(newEntry)
    }
}

