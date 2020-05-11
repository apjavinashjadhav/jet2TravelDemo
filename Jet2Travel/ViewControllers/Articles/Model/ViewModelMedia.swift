//
//  ViewModelMedia.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation
import UIKit

class ViewModelMedia {
    var id: String?
    var blogId: String?
    var createdAt: String?
    var image: String?
    var title: String?
    var url: String?
    
    init() {
        self.id = ""
        self.blogId = ""
        self.createdAt = ""
        self.image = ""
        self.title = ""
        self.url = ""
        
    }
    
    required init(media:ModelMedia) {
        self.id = media.id
        self.blogId = media.blogId
        self.createdAt = media.createdAt
        self.image = media.image
        self.title = media.title
        self.url = media.url
        
        
    }
}
