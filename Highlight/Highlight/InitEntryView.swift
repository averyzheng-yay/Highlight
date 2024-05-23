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

struct JournalListView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    @Binding var showingAddEntry: Bool
    
    var body: some View {
        VStack {
            Text("Highlight")
                .customFont(.medium, 30)
                .padding(.top, 20)
            
            List {
                ForEach(viewModel.entries) { entry in
                    NavigationLink(destination: EntryView(ent: entry)) {
                        InitEntryView(ent: entry)
                        
                    }
                }
            }
            
            Button(action: { showingAddEntry.toggle() }) {
                Text("Add New Entry")
                    .customFont(.regular, 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showingAddEntry) {
                if #available(iOS 15.0, *) {
                    AddEntryView(viewModel: viewModel)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        .navigationTitle("Your Highlights")
    }
}
