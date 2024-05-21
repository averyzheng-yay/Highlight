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

struct PhotoEntry: Identifiable {
    var id = UUID()
    var title: String
    var image: UIImage
    var date: Date
}










