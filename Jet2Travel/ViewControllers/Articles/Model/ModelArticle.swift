//
//  ModelArticle.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation
/*
 "id": "1",
 "createdAt": "2020-04-17T12:13:44.575Z",
 "content": "calculating the program won't do anything, we need to navigate the multi-byte SMS alarm!",
 "comments": 8237,
 "likes": 62648,
 "media": [
 */


import Foundation

struct ModelArticle: Codable {
    let id: String?
    let content: String?
    let createdAt: String?
    let comments: Int?
    let likes: Int?
    let media: [ModelMedia]?
    let user: [ModelUser]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "content"
        case createdAt = "createdAt"
        case comments = "comments"
        case likes = "likes"
        case media = "media"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        media = try values.decodeIfPresent([ModelMedia].self, forKey: .media)
        user = try values.decodeIfPresent([ModelUser].self, forKey: .user)
    }
}
