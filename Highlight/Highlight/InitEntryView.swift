//
//  InitEntryView.swift
//  Highlight
//

import SwiftUI

struct InitEntryView: View {
    var ent: Entries
    var body: some View {
        if let photoEntry = ent as? PhotoEntries {
            HStack {
                Image(uiImage: photoEntry.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(photoEntry.title)
                        .customFont(.regular, 18)
                    Text(photoEntry.date, style: .date)
                        .customFont(.regular, 14)
                        .foregroundColor(.gray)
                }
            }
        } else if let textEntry = ent as? TextEntries {
            // only a temporary view - change later (eventually completely change textEntries to a different type)
            VStack(alignment: .leading) {
                Text(textEntry.title)
                    .customFont(.regular, 18)
                Text(textEntry.date, style: .date)
                    .customFont(.regular, 14)
                    .foregroundColor(.gray)
            }
        } else {
            Text("Unknown entry type")
        }
    }
}

