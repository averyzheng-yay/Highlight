//
//  JournalListView.swift
//  Highlight
//

import SwiftUI

struct InitEntryView: View {
    var ent: Entries
    var body: some View {
        VStack{
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
            } else {
                Text("Unknown entry type")
            }
        }
    }
}

struct JournalListView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    @Binding var showingAddEntry: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.3, green: 0.5, blue: 1), Color(red: 0.678, green: 0.847, blue: 0.902)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                        Text("Highlight")
                            .customFont(.medium, 40)
                            .padding()
                    }
                }
                .frame(maxHeight: 100)
                
                if (viewModel.entries.isEmpty){
                    ZStack{
                        Color(.systemGray6)
                        VStack{
                            Text("Create your first photo entry!")
                                .customFont(.light, 30)
                                .padding()
                            Spacer()
                        }
                    }
                }
                
                else {
                    List {
                        ForEach(viewModel.entries) { entry in
                            NavigationLink(destination: EntryView(ent: entry)) {
                                InitEntryView(ent: entry)
                            }
                        }
                    }
                    .background(Color(.systemGray6))
                }

                Spacer(minLength: 20)
                
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
        }
    }
}



