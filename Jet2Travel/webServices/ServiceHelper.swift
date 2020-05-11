//
//  ServiceHelper.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class ServiceHelper: NSObject, WKNavigationDelegate {
    
    static let shared = ServiceHelper()
    
    public func getArticleList(handler:UIViewController, completion:@escaping(_ articleList:[ModelArticle]?, _ error:Error?)->()){

        if (Helper.shared.isConnectedToNetwork() == false){
            DispatchQueue.main.async {
                handler.showAlert(with: "", message: kNoNetworkMsg)
            }
            return
        }
        DispatchQueue.main.async { Helper.shared.activityStartAnimating() }
        Services.shared.requestWithURL(url: API.getArticles , withRequestType: RequestType.GET, param: nil) { (json, httpURLResponse, error) in
            DispatchQueue.main.async {
                print(json)
                Helper.shared.activityStopAnimating()
                if let error = error {
                    handler.showAlert(with: "", message: error.localizedDescription)
                    completion(nil, error)
                    return
                }
            }
            if json != nil{
                do {
                let orgList = try? JSONDecoder().decode([ModelArticle].self, from: json.rawData())
                completion(orgList, nil)
                } catch {
                    
                }
            }else{
                DispatchQueue.main.async {
                    handler.showAlert(with: "", message: "Opps, server responded with null.")
                }
            }
        }
    }
    
 
  
}
