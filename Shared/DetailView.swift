//
//  DetailView.swift
//  Contacts
//
//  Created by Vinay Singh on 29/03/21.
//

import SwiftUI
import Combine
struct DetailView: View {
    
    @State private var selectedFile:String = ""
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @Binding var fristName:String
    @Binding var lastName:String
    @Binding var id:UUID
    @Binding var number:String
    @Binding var showingAlert:Bool
    @Binding var contacts:[ContactModel]
    @Binding var index:Int
    @Binding var val:Bool
    @Binding var total:Int
    @Binding var createNew:Bool
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("First Name")
                        .foregroundColor(.white)

                }.padding()
                Spacer()
                VStack {
                    TextField("Enter First Name", text: $fristName)
                        .padding(.leading,20)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 40, alignment: .trailing)
                        .border(Color.white, width: 1)
                }.padding()
            }
            
            HStack {
                VStack {
                    Text("Last Name")
                        .foregroundColor(.white)

                }.padding()
                Spacer()
                VStack {
                    TextField("Enter Last Name", text: $lastName)
                        .padding(.leading,20)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 40, alignment: .trailing)
                        .border(Color.white, width: 1)
                }.padding()
            }
            
            HStack {
                VStack {
                    Text("Number")
                        .foregroundColor(.white)

                }.padding()
                Spacer()
                VStack {
                    TextField("Enter Number", text: $number)
                        .padding(.leading,20)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 40, alignment: .trailing)
                        .border(Color.white, width: 1)
                }.padding()
            }
            
            ZStack {
                        HStack {
                            Button(action: {
                                self.showImagePicker.toggle()
                            }) {
                                Text("Select Image")
                                    
                                    .frame(width: 140, height: 70)
                                    .foregroundColor(.pink)
                                    .background(Color.black)
                                    .cornerRadius(5)
                            }
                            image?.resizable().frame(width: 100, height: 100)
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(sourceType: .photoLibrary) { image in
                                self.image = Image(uiImage: image)
                                if let data = image.pngData() {
                                    let filename = getDocumentsDirectory().appendingPathComponent(id.uuidString)
                                        try? data.write(to: filename)
                                    self.selectedFile = filename.path
                                    print(self.selectedFile)
                                }
                            }
                        }
                    }
            
            
            
            
            if createNew{
                
                Button(action: {
                    self.showingAlert.toggle()
                }, label: {
                    btnnew()
                    
                })
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to add this?"),
                        message: Text("This will create a new contact"),
                        primaryButton: .destructive(Text("ADD")) {
                            self.val.toggle()
                            contacts.append(ContactModel(firstName: fristName, lastName: lastName, phoneNumber: number, photo: selectedFile))
                            print(index)
                            self.total-=1
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                
                
                
                
            }
            else{
                
                
                Button(action: {
                    self.showingAlert.toggle()
                }, label: {
                    btndelete()
                    
                })
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Delete")) {
                            self.val.toggle()
                            contacts.remove(at: index)
                            print(index)
                            self.total-=1
                        },
                        secondaryButton: .cancel()
                    )
                }

            }
            
                    
            
            Spacer()
    }
}

}
struct btndelete:View {
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.pink)
                .frame(width: 170, height: 70, alignment: .center)
                .background(Color.blue)
            Text("Delete")
                .foregroundColor(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10 )
    }
}
struct btnnew:View {
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(lineWidth: 1.0)
                .foregroundColor(.pink)
                .frame(width: 170, height: 70, alignment: .center)
                .background(Color.blue)
            Text("Create")
                .foregroundColor(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10 )
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    private var presentationMode

    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void

    final class Coordinator: NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void

        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            print((info))
            onImagePicked(uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}


struct ContentViewds_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
