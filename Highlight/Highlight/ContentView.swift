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
                        if let photoEntry = entry as? PhotoEntries {
                            HStack {
                                Image(uiImage: entry.image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(entry.title)
                                        .customFont(.regular, 18)
                                    Text(entry.date, style: .date)
                                        .customFont(.regular, 14)
                                        .foregroundColor(.gray)
                                }
                            }
                        } else if let textEntry = entry as? TextEntries {
                            Text("temp")
                        } else {
                            Text("Unknown entry type")
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
                    AddEntryView(viewModel: viewModel)
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

#Preview {
    ContentView()
}
