
// This is the popup screen when creating a new entry

import SwiftUI

@available(iOS 15.0, *)
struct AddEntryView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("New Entry")
                    .customFont(.semibold, 34)
                    .padding()
                
                TextField("Title", text: $title)
                    .customFont(.regular, 20)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    showingImagePicker = true
                }) {
                    Text("Select Image")
                        .customFont(.regular, 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $image)
                }
                
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                    TextEditor(text: $text)
                        .background(Color(.systemGray6))
                        .padding(4) // Add padding inside the TextEditor to avoid text touching the edges
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    if let image = image {
                        viewModel.addEntry(title: title, image: image, text: text)
                        self.presentationMode.wrappedValue.dismiss()
                    }}) {
                        Text("Add Entry")
                            .customFont(.regular, 20)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background((title.isEmpty) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .disabled(title.isEmpty && image == nil)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            AddEntryView(viewModel: PhotoJournalViewModel())
        } else {
            // Fallback on earlier versions
        }
    }
}



