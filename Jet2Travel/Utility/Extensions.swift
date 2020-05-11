//
//  Extensions.swift
//  Jet2Travel
//
//  Created by AVINASH JADHAV on 06/05/20.
//  Copyright © 2020 ABC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func showAlert(with title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }
}


extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        var msg = ""
        if let month = interval.month, month > 0 {
            return  dateFormatTime(date: self)
        }else if let day = interval.day, day > 0 {
            // WITHIN A MONTHS
            return (day == 1 ? "\(day)" + " day" : "\(day)" + " days") + " ago"
        }else if let hour = interval.hour, hour > 0 {
            // WITHIN 24 HOURS
            msg = (hour == 1 ? "\(hour)" + " hour" : "\(hour)" + " hours")
            if let minute = interval.minute, minute > 0 {
                msg = msg + " " + (minute == 1 ? "\(minute)" + " minute" : "\(minute)" + " minutes")
            }
            return msg  + " ago"
        } else
            if interval.year == 0 && interval.month == 0 && interval.day == 0 && interval.hour == 0 && interval.minute == 0 {
                return "a moment ago"
        }
        return "a moment ago"
    }
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //"dd MMM, yyyy hh:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}

extension String {
    func dateFromString()->Date{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        //        let dateFormatterPrint = DateFormatter()
        //        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date = dateFormatterGet.date(from: self)!
        // print(dateFormatterPrint.stringFromDate(date!))
        
        return date
    }
}
