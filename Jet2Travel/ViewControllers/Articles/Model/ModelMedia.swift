//
//  ModelMedia.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation

struct ModelMedia: Codable {
    let id: String?
    let blogId: String?
    let createdAt: String?
    let image: String?
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case image = "image"
        case title = "title"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
