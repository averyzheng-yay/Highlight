//
//  JournalListView.swift
//  Highlight
//

import SwiftUI

// View used for displaying each entry in the list
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

// SearchBar for implementing search feature in list
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

// First tab view; displays all entries succinctly
struct JournalListView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    
    @Binding var showingAddEntry: Bool // Variable to control AddEntryView
    
    // Variables used for searching
    @State private var searchText = ""
    @State private var startDate = Date().addingTimeInterval(-60*60*24*30)
    @State private var endDate = Date()
    
    // All entries that contain the searchText in the title or description and are in the rnage of dates
    var filteredEntries: [Entries] {
        if searchText.isEmpty {
            return viewModel.entries
        } else {
            return viewModel.entries.filter { entry in
                let matchesTitleOrDescription = entry.title.localizedCaseInsensitiveContains(searchText) || entry.text.localizedCaseInsensitiveContains(searchText)
                let matchesDateRange = entry.date >= startDate && entry.date <= endDate.addingTimeInterval(60*60*24) // Edge case; adds 24 more hours to the end date
                return matchesTitleOrDescription && matchesDateRange
            }
        }
    }
    
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
                
                SearchBar(text: $searchText)
                    .padding()
                
                if (searchText != "") {
                    HStack {
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                    }
                    .padding()
                } else {
                    EmptyView()
                }
                
                
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
                } else {
                    // Actual list that displays all filtered entries
                    List {
                        ForEach(filteredEntries) { entry in
                            NavigationLink(destination: EntryView(ent: entry)) {
                                InitEntryView(ent: entry)
                            }
                        }
                        .onDelete(perform: deleteEntry) // entries can be deleted with a swipe
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
    
    private func deleteEntry(at offsets: IndexSet) {
        offsets.forEach { index in
            let entry = filteredEntries[index]
            viewModel.removeEntry(entry: entry)
        }
    }
}



