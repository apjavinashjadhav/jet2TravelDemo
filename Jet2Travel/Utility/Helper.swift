//
//  Helper.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import UIKit
import SystemConfiguration
import SwiftyJSON

//error messages
let kNoNetworkMsg = "No Internet Connection."


class Helper: NSObject {
    static let shared = Helper()
    
    private override init(){}
    
    func getPatchObjec(forKey key:String, value:String)->NSDictionary{
        let obj = NSDictionary(dictionaryLiteral: ("op", "replace"), ("path", "/\(key)"), ("value", value))
        return obj
    }
    
   
    func activityStartAnimating() {
        guard let windowView = UIApplication.shared.keyWindow else{
            return
        }
        
        let backgroundView = UIView(frame: windowView.bounds)
        backgroundView.backgroundColor = .clear
        backgroundView.tag = 475647
        
        let squareView = UIView(frame: CGRect.init(x: 0, y: 0, width: 75, height: 75))
        squareView.center = windowView.center
        squareView.backgroundColor = UIColor.black
        squareView.alpha = 1.0
        squareView.layer.cornerRadius = 10
        squareView.clipsToBounds = true
        squareView.isUserInteractionEnabled = false
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x:squareView.frame.width/2-25, y: squareView.frame.width/2-25, width: 50, height: 50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = UIColor.white
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        squareView.addSubview(activityIndicator)
        backgroundView.addSubview(squareView)
        windowView.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        guard let windowView = UIApplication.shared.keyWindow else{
            return
        }
        
        if let background = windowView.viewWithTag(475647){
            background.removeFromSuperview()
        }
    }
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
   
}

extension UIDevice {
    enum DeviceType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX_Xs_11pro = "iPhone X, iPhone Xs, iPhone 11Pro"
        case iPhoneXR_11 = "iPhone XR, iPhone 11"
        case iPhoneXsMax_11ProMax = "iPhone XsMax, iPhone 11ProMax"
        case unknown = "iPadOrUnknown"
    }
    var deviceType: DeviceType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX_Xs_11pro
        case 1792:
            return .iPhoneXR_11
        case 2688:
            return .iPhoneXsMax_11ProMax
        default:
            return .unknown
        }
    }
}
