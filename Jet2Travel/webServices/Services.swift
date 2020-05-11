//
//  Services.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import UIKit
import SwiftyJSON

class Services: NSObject {
    static let shared = Services()
    static let INTERVAL_FOR_REQUEST = 10.0
    static let INTERVAL_FOR_RESOURCE = 40.0
    
    public func requestWithURL( url:String, withRequestType: RequestType ,param:AnyObject?,  completion: @escaping (_ jsonResponse:JSON, _ httpResponse:HTTPURLResponse?, _ error:Error?)->()){
        
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = withRequestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let param = param {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) else {
                return
            }
            request.httpBody = httpBody
        }
        print("requested API: \(url) requested params: \(param?.description ?? "")")
        
        // let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Services.INTERVAL_FOR_REQUEST
        sessionConfig.timeoutIntervalForResource = Services.INTERVAL_FOR_RESOURCE
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse{
                if response.statusCode == 200, let data = data {
                    let json = JSON(data)
                    completion(json, response, nil)
                }else{
                    completion(JSON.null, response, error)
                }
            }else if error != nil {
                completion(JSON.null, nil, error)
            }
            }.resume()
    }
    
    public func request_PATCH_withURL( url:String, param:NSArray?, completion: @escaping (_ jsonResponse:JSON, _ httpResponse:HTTPURLResponse?, _ error:Error?)->()){
        
        guard let serviceUrl = URL(string: url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = RequestType.PATCH.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let param = param {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        //print("requested API: \(url) requested params: \(param?.description ?? "")")
        // let session = URLSession.shared
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Services.INTERVAL_FOR_REQUEST
        sessionConfig.timeoutIntervalForResource = Services.INTERVAL_FOR_RESOURCE
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse{
                if response.statusCode == 200, let data = data {
                    let json = JSON(data)
                    completion(json, response, nil)
                }else{
                    completion(JSON.null, response, nil)
                }
            }else if error != nil {
                completion(JSON.null, nil, error)
            }
            }.resume()
    }
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    public func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        //print("getDataFromUrl = \(url)")
        URLSession.shared.dataTask(with: URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    self.imageCache.setObject(data as AnyObject, forKey: url as AnyObject)
                    completion(data, response, error)
                }else{
                    completion(nil, response, error)
                }
            }else{
                completion(nil, response, error)
            }
            
            }.resume()
        }
//        session.dataTask(with: url) { data, response, error in
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    completion(data, response, error)
//                }else{
//                    completion(nil, response, error)
//                }
//            }else{
//                completion(nil, response, error)
//            }
//
//            }.resume()
    
}
