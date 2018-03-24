//
//  UtilityFunctions.swift
//  CDLExam
//
//  Created by adeiji on 3/19/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

class UtilityFunctions {
    
    class func toBool (value: String?) -> Bool  {
        if value == "true" {
            return true
        } else if value == "false" {
            return false
        } else {
            return false;
        }
    }

    class func dateToString (date: Date, style: DateFormatter.Style) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = style
        if style != .short {
            dateformatter.timeStyle = .short
        } else {
            dateformatter.timeStyle = .none
        }
        
        let stringDate = dateformatter.string(from: date)
        return stringDate
    }

    class func loadExam (form: String) -> [String:Any] {
        if let fileUrl = Bundle.main.url(forResource: "exam-criteria", withExtension: "plist"),
            // Load exam data
            let data = try? Data(contentsOf: fileUrl) {
            if var result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String:Any] {
                if form == kFormA {
                    result![kFormC] = nil;
                    result![kFormB] = nil;
                } else if form == kFormB {
                    result![kFormA] = nil;
                    result![kFormC] = nil;
                } else {
                    result![kFormA] = nil;
                    result![kFormB] = nil;
                }
                
                result!["Vehicle Info"] = nil;
                return result!;
            }
        }
        
        // Handle Error, there should always be a result returned
        return [String:Any]();
    }
}
