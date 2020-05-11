//
//  ViewModelArticle.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation
import UIKit

class ViewModelArticle {
    var id: String?
    var content: String?
    var createdAt: String?
    var comments: Int?
    var likes: Int?
    var media: [ViewModelMedia]?
    var user: [ViewModelUser]?
    
    init() {
        id = ""
        content = ""
        createdAt = ""
        comments = 0
        likes = 0
        media = []
        user = []
    }
    
    required init(article:ModelArticle) {
        self.id = article.id
        self.content = article.content
        self.createdAt = article.createdAt
        self.comments = article.comments
        self.likes = article.likes
        media = [ViewModelMedia]()
        user = [ViewModelUser]()
        for item in article.media ?? [] {
            media?.append(ViewModelMedia(media: item))
        }
        for item in article.user ?? [] {
            self.user?.append(ViewModelUser(user: item))
        }
    }
}
