//
//  ViewModelUser.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation

class ViewModelUser {
    var id: String?
    var blogId: String?
    var createdAt: String?
    var name: String?
    var avatar: String?
    var lastname: String?
    var city: String?
    var designation: String?
    var about: String?
    
    init() {
        self.id = ""
        self.blogId = ""
        self.createdAt = ""
        self.name = ""
        self.avatar = ""
        self.lastname = ""
        self.city = ""
        self.designation = ""
        self.about = ""
    }
    
    required init(user:ModelUser) {
        self.id = user.id
        self.blogId = user.blogId
        self.createdAt = user.createdAt
        self.name = user.name
        self.avatar = user.avatar
        self.lastname = user.lastname
        self.city = user.city
        self.designation = user.designation
        self.about = user.about
    }
}
