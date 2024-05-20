//
//  PhotoEntries.swift
//  Highlight

//PhotoEntries:
//- has-a Photo
//- can be co-owned? by ≥1 Users (Relational database stuff)
//- can have a written description (optional)
//- date
//- possible metadata

import Foundation

class PhotoEntries: Entry {
    var Photo: Photo
    var Date: Date
    var Description: String
    
    init(Photo: Photo, Date: Date, Description: String) {
        super.init(Date: Date, Description: Description)
    }
    
}

