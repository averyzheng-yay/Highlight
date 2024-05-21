//
//  JournalModel.swift
//  Highlight
//
//

import Foundation

class JournalModel: ObservableObject {
    
    init() {
        // for initializing later variables
    }
    
    @Published var journalEntries: [Entry] = []
    
    func addEntry(Entry: Entry) {
        journalEntries.append(Entry)
    }
    
    func removeEntry(Int: Int) {
        journalEntries.remove(at: Int)
    }
}
