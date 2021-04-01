//
//  ContactModel.swift
//  Contacts
//
//  Created by Vinay Singh on 29/03/21.
//

import Combine
import Foundation

class ContactModel: Identifiable {
    
    var id: UUID
    var firstName:String
    var lastName:String
    var phoneNumber:String
    var photo:String
    
    
    init(firstName: String,lastName:String, phoneNumber: String, photo: String) {
        self.firstName=firstName
        self.lastName=lastName
        self.phoneNumber = phoneNumber
        self.photo = ""
        self.id = UUID()
    }
    
    
    init() {
        self.firstName=""
        self.lastName=""
        self.phoneNumber = ""
        self.photo = ""
        self.id = UUID()
    }
}
