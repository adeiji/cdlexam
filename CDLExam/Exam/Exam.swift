//
//  Exam.swift
//  CDLExam
//
//  Created by adeiji on 3/18/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

class Exam {
    
    var name:String!
    var number:Int!
    var date:Date!
    var driversLicense:String!
    var vehicle:String!
    var type:String!
    var examClass:String!
    var form:String!
    var passPoints:Int!
    var vehicleAxles:String!
    var trailerAxles:String!
    var airBrakes:String!
    var gvwr:String!
    
    init() {}
    
    init(name: String, date: Date, driversLicense: String, vehicle: String, type: String, examClass: String) {
        self.name = name;
        self.date = date;
        
        self.vehicle = vehicle;
        self.type = type;
        self.examClass = examClass;
    }
}
