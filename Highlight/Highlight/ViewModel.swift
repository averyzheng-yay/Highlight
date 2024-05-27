// PhotoJournalViewModel.swift

import SwiftUI

// Back end class
class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [Entries] = [] // Array that stores all entries
    private let locationManager = LocationManager()
    
    func addEntry(title: String, image: UIImage, text: String) {
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let location = self.locationManager.location
            let newEntry = PhotoEntries(title: title, image: image, text: text, date: Date(), location: location)
            self.entries.insert(newEntry, at:0)
            self.locationManager.stopUpdatingLocation()
            // Makes sure to only record the location when adding the entry
        }
    }
    
    func removeEntry(entry: Entries) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries.remove(at: index) // only removes the entry that matches the id of the entry given
        }
    }
    
    // Variable used to create the collage later
    var allPhotos: [UIImage] {
        entries.compactMap { $0 as? PhotoEntries }.map { $0.image }
    }
}

