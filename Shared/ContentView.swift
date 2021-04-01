//
//  ContentView.swift
//  Shared
//
//  Created by Vinay Singh on 29/03/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var id = UUID()
    @State var number:String = ""
    @State var val = false
    @State var index:Int=0
    @State var total:Int=0
    @State var createNew:Bool=false
    
    @State var contacts = [ContactModel(firstName: "Vinay", lastName: "Singh", phoneNumber: "9680479955", photo: "1DF1EDAD-9949-490A-9273-573EBE51B9AA"),ContactModel(firstName: "Vinay", lastName: "Singh", phoneNumber: "9680479955", photo: "/Users/vinaysingh/Library/Developer/CoreSimulator/Devices/3E7C617D-522A-48B3-AA99-9D3EB313958C/data/Containers/Data/Application/D202CCF5-9868-4A22-9C36-A85B8DC17A15/Documents/1DF1EDAD-9949-490A-9273-573EBE51B9AA")]
    
    
    
    var body: some View {
        
            NavigationView{
                    ZStack {
                    Color.black
                        .ignoresSafeArea()
                    VStack {
                        Text("Contacts")
                            .foregroundColor(.white)
                            .font(.title)
                        
                        ListUIView(firstName: $firstName, lastName: $lastName, id: $id, number: $number, val: $val, contacts: $contacts, index: $index, total: $total, createNew: $createNew)
                                  
                        
                        
                            
                        HStack {
                            Spacer()
                            ZStack{
                                Circle()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Button(action: {
                                    firstName = ""
                                    lastName = ""
                                    id = UUID()
                                    number = ""
                                    createNew=true
                                    val.toggle()
                                    
                                    
                                    
                                }, label: {
                                    Text("+").font(.title)
                                        .foregroundColor(.black)
                                    
                                })
                                
                            }.padding()
                        }
                        
                            }
                        }
                    
            }
        }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





