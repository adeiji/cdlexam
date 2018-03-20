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
    
}
