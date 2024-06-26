
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
                // Select Image button; shows the ImagePicker view when pressed and stores the image in the image variable
                
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
                
                ZStack {
                    Color(.systemGray6)
                    VStack{
                        Spacer()
                        Text("Optional Description Below")
                            .customFont(.light, 20)
                        TextEditor(text: $text)
                            .background(Color(.clear))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 220)
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
                            .background((title.isEmpty || image == nil) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .disabled(title.isEmpty || image == nil)
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



