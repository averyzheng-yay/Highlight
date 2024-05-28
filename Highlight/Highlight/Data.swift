//
//  Data.swift
//  Highlight
//

// Stores entry-type classes as well as miscellaneous functions and location manager class

import SwiftUI
import CoreLocation

// General entry class (Parent Class)
class Entries: Identifiable, ObservableObject {
    var id = UUID()
    @Published var title: String
    @Published var text: String
    @Published var date: Date
    @Published var location: CLLocation?
    
    init(title: String, text: String, date: Date, location: CLLocation?) {
        self.title = title
        self.text = text
        self.date = date
        self.location = location
    }
}

// Entries with photos (Child Class; inherits most variables from Entries)
class PhotoEntries: Entries {
    @Published var image: UIImage
    
    init(title: String, image: UIImage, text: String, date: Date, location: CLLocation?) {
        self.image = image
        super.init(title: title, text: text, date: date, location: location)
    }
}

// Function for saving a view as an image; used for the export function in CollageView
func saveImageAsJPG(_ image: UIImage) -> URL? {
    guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
    
    let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("collage.jpg")
    
    do {
        try data.write(to: tempURL)
        return tempURL
    } catch {
        print("Error saving image: \(error.localizedDescription)")
        return nil
    }
}

// Class for managing the current location of the user
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        self.location = latestLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
