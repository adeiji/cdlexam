//
//  ExamResults.swift
//  CDLExam
//
//  Created by adeiji on 3/17/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation
import RealmSwift

final class ExamResults {
    static let sharedInstance = ExamResults()
    var results = [String:String]();
    var exam:Exam!
    
    private init() {}
    
    public func addResult (key: String, value: String) {
        self.results[key] = value;
    }
    
    public func getResult (key: String) -> String? {
        return self.results[key];
    }
    
    public func getResults () -> [String:Any] {
        return self.results;
    }
    
    public func loadResults () {
        let realm = try! Realm()
        let exams = realm.objects(ExamObject.self)
        let exam = exams[0];
        for result in exam.resultList {
            self.results[result.resultValue] = result.resultValue;
        }
    }
    
    public func saveExamResults (exam: Exam, passed: Bool) -> Bool {
        let examObject = ExamObject();
        examObject.clientId = UUID().uuidString;
        examObject.passed = passed;
        examObject.date = exam.date;
        examObject.name = exam.name;
        examObject.license = exam.driversLicense;
        examObject.vehicle = exam.vehicle;
        examObject.type = exam.type;
        examObject.examClass = exam.examClass;
        
        // Value can only be of type Boolean or of type string
        for (key, value) in self.results {
            let resultsObject = ResultsObject()
            resultsObject.resultKey = key;
            resultsObject.resultValue = value;
            
            examObject.resultList.append(resultsObject)
            
        }
        
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(examObject)
            }
        } catch {
            print("Unexpected error: \(error).")
            return false;
        }
        
        return true;
    }
}

class ExamObject: Object {
    @objc dynamic var clientId = "";
    @objc dynamic var passed = false;
    @objc dynamic var date = Date();
    @objc dynamic var name = "";
    @objc dynamic var license = "";
    @objc dynamic var vehicle = "";
    @objc dynamic var type = "";
    @objc dynamic var examClass = "";
    
    let resultList = List<ResultsObject>();
}

class ResultsObject: Object {
    @objc dynamic var resultsId = "";
    @objc dynamic var resultKey = "";
    @objc dynamic var resultValue = "";
}
