//
//  SwiftUIView.swift
//  Contacts
//
//  Created by Vinay Singh on 30/03/21.
//

import SwiftUI
import Combine
struct ListUIView: View {
    @Binding var firstName:String
    @Binding var lastName:String
    @Binding var id:UUID
    @Binding var number:String
    
    @Binding var val:Bool
    @Binding var contacts:[ContactModel]
    @Binding var index:Int
    @Binding var total:Int
    @Binding var createNew:Bool
    
    
    
    @State private var showingAlert=false
    
    
    private func onDelete(offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }

    // 3.
    private func onMove(source: IndexSet, destination: Int) {
        contacts.move(fromOffsets: source, toOffset: destination)
    }
    var body: some View {
        
            
                
        VStack{
            List{
            ForEach(contacts){nn in
                Button(action: {
                    self.id = nn.id
                    self.firstName = nn.firstName
                    self.lastName = nn.lastName
                    self.number = nn.phoneNumber
                    self.index=total
                    self.total+=1
                    withAnimation(.easeInOut, {
                        self.val.toggle()
                    })
                }, label: {
                    
                    buttonView(ccc: nn)
                    
                })
                
                .sheet(isPresented: $val, content: {
                    ZStack {
                            Color.blue
                                .ignoresSafeArea()
                            VStack{
                                HStack{
                                Button(action: {
                                    self.val.toggle()
                                }, label: {
                                    
                                    HStack {
                                        Spacer()
                                        Text("Close")
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                })
                            }
                        
                        
                            
                        VStack{
                            DetailView(fristName: $firstName,lastName: $lastName, id: $id, number: $number, showingAlert: $showingAlert, contacts: $contacts, index: $index, val: $val, total: $total, createNew: $createNew)
                            }
                        }
                    }
                    
                })
            
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
            }
            
            
            .navigationBarTitle(Text("Nav Title"))
            .navigationBarItems(trailing: EditButton())
            
            
        }
                    
                    
                    
            
        }

        struct buttonView:View {
            
            
            var ccc:ContactModel
            var body: some View{
                ZStack {
                    
                    HStack{
                        HStack{
                            
                            if fileExists(at: ccc.photo){
                                
                                Image(uiImage: loadImage(at: ccc.photo)!)
                                
                            }
                            else{
                                Image(systemName: "person.fill")
                                    .frame(width: 100, height: 100)
                                    .font(.system(size: 50))
                            }
                            
                            
                                            
                                
                            VStack{
                                HStack{
                                    Text(ccc.firstName)
                                        .foregroundColor(.black)
                                    Spacer()
                                
                                }
                                HStack{
                                    Text(String(ccc.phoneNumber))
                                        
                                        .padding(.top,1)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                Spacer()
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            }
    }
    

func loadImage(at path: String) -> UIImage? {
//    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//    let documentPath = paths[0]
//    let imagePath = documentPath.appending(path)
    let imagePath=path
    print(imagePath)
    guard fileExists(at: imagePath) else {
        return nil
    }
    guard let image = UIImage(contentsOfFile: imagePath) else {
        return nil
    }
    return image
}

func fileExists(at path: String) -> Bool {
    return FileManager.default.fileExists(atPath: path)
}
