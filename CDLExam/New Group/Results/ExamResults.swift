//
//  ExamResults.swift
//  CDLExam
//
//  Created by adeiji on 3/17/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

final class ExamResults {
    static let sharedInstance = ExamResults()
    var results = [String:Bool]();
    
    private init() {}
    
    public func addResult (key: String, value: Bool) {
        self.results[key] = value;
    }
    
    public func getResult (key: String) -> Bool {
        if self.results[key] != nil {
            return self.results[key]!;
        } else {
            return false;
        }
    }
    
    public func getResults () -> [String:Bool] {
        return self.results;
    }
}
