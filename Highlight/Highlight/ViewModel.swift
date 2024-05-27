// PhotoJournalViewModel.swift

import SwiftUI

class PhotoJournalViewModel: ObservableObject {
    @Published var entries: [Entries] = []
    private let locationManager = LocationManager()
    
    func addEntry(title: String, image: UIImage, text: String) {
        locationManager.startUpdatingLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let location = self.locationManager.location
            let newEntry = PhotoEntries(title: title, image: image, text: text, date: Date(), location: location)
            self.entries.insert(newEntry, at:0)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    var allPhotos: [UIImage] {
        entries.compactMap { $0 as? PhotoEntries }.map { $0.image }
    }
}

