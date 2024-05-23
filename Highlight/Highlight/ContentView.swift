//
//  ContentView.swift
//  Highlight
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoJournalViewModel()
    @State private var showingAddEntry = false
    
    var body: some View {
        NavigationView {
            JournalListView(viewModel: viewModel, showingAddEntry: $showingAddEntry)
                .tabItem{Label("Journal", systemImage: "book")}
        }
    }
}

extension View {
    func customFont(_ weight: Font.Weight, _ size: CGFloat) -> some View {
        self.font(.system(size: size, weight: weight))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
