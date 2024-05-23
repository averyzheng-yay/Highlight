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
            VStack {
                Text("Highlight")
                    .customFont(.medium, 30)
                    .padding(.top, 20)
                
                List {
                    ForEach(viewModel.entries) { entry in
                        EntryView(ent: entry)
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
