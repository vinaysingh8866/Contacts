//
//  ContactListModel.swift
//  Contacts
//
//  Created by Vinay Singh on 30/03/21.
//

import Foundation


class ContactListModel {
    var list = [ContactModel]()
    
    init() {
        list=[]
    }
    
    init(list: [ContactModel]) {
        self.list = list
    }
    
    func addContact(firstName:String,lastName:String,phoneNumber:String,photo:String){
        list.append(ContactModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, photo: photo))
    }
    
    func removeContact(offsets: IndexSet) {
        list.remove(atOffsets: offsets)
    }
    
    func removeContactBB(index: Int) {
        list.remove(at: index)
    }
    
    
    
    func moveContact(source: IndexSet, destination: Int) {
        list.move(fromOffsets: source, toOffset: destination)
    }
    
    
}
