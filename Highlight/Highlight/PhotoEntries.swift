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

class PhotoEntries {
    var Photo: Photo
    var Date: Date
    var Description: String
    
    init(Photo: Photo, Date: Date, Description: String) {
        self.Photo = Photo
        self.Date = Date
        self.Description = Description
    }
    
}

