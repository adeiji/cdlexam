//
//  LoadExamInfoProtocol.swift
//  CDLExam
//
//  Created by adeiji on 3/16/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

protocol LoadExamInfoDelegate: class {
    func loadExamDetailsArray(info: [String], header: String, resultKey: String);
    func loadExamDetailsDictionary(info: [String:Any], headers: [String], resultKey: String);
}
