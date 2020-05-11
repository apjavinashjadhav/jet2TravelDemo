//
//  API.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation

struct API {
    //DEV
    
    private static let baseURL:String = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
    
    static let getArticles = { return API.baseURL + APIName.getArticles.rawValue }()
    
    fileprivate enum APIName:String {
        case getArticles = "blogs?page=1&limit=10"
    }
}
