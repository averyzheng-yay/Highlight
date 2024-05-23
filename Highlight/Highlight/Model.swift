//
//  Data.swift
//  Highlight
//

/*“Objects” to work with:

Users:
 - user must log in or sign up, retrieving or creating a “User” object
 - friend relation to other Users
 - has-a relation to Entries and PhotoEntries
 
 Entries:
 - bullet journal
 - date
 - metadata (location, etc. depending on user’s privacy settings)
 - owned by a User
 
 PhotoEntries:
 - has-a Photo
 - can be co-owned? by ≥1 Users (Relational database stuff)
 - can have a written description (optional)
 - date
 - possible metadata
 
 Photo:
 - object abstracting the storage of a photo in database and potential methods for displaying it in SwiftUI
 
 
 This should be most of the objects we will work with. Other methods and front-end stuff would determine how memories/agenda/calendar/etc. works. Let’s try to make use of existing libraries and not “reinvent the wheel” this time.
*/

// PhotoEntry.swift

import SwiftUI

class Entries: Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    
    init(title: String, date: Date) {
        self.title = title
        self.date = date
    }
}

class PhotoEntries: Entries, ObservableObject {
    var image: UIImage
    var text: String
    
    init(title: String, image: UIImage, text: String, date: Date) {
        self.image = image
        self.text = text
        super.init(title: title, date: date)
    }
}

// will change later to a different type of entry - doesn't need to be a text entry
// just framework for later
class TextEntries: Entries, ObservableObject {
    var text: String
    
    init(title: String, text: String, date: Date) {
        self.text = text
        super.init(title: title, date: date)
    }
}

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
