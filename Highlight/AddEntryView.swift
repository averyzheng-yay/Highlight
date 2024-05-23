import SwiftUI

@available(iOS 15.0, *)
struct AddEntryView: View {
    @ObservedObject var viewModel: PhotoJournalViewModel
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    @Environment(\.presentationMode) var presentationMode
    
    //eventually will want an intermediate screen to choose what type of entry you want it to be
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
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
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                TextEditor(text: $text)
                
                Button(action: {
                    if let image = image {
                        viewModel.addEntry(title: title, image: image)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        viewModel.addEntry(title: title, text: text)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add Entry")
                        .customFont(.regular, 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background((title.isEmpty) ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(title.isEmpty)
            }
            .navigationTitle("New Entry")
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



