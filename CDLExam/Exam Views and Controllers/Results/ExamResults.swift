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
    var exam:ExamObject! {
        willSet(myExam) {
            self.setResults(exam: myExam)
        }
    }
    
    private init() {}
    
    public func addResult (key: String, value: String) {
        self.results[key] = value;
    }
    
    public func getResult (key: String) -> String? {
        return self.results[key];
    }
    
    public func setResults (exam: ExamObject){
        for result in exam.resultList {
            self.results[result.resultKey] = result.resultValue;
        }
    }
    
    public func deleteRealmObject (object: Object) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Unexpected error: \(error).")
            return false;
        }
        
        return true
    }
    
    public func loadExams () -> [ExamObject] {
        
        do {
            let realm = try Realm()
            
            let exams = realm.objects(ExamObject.self)
            
            return Array(exams);
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return [ExamObject]();
    }
    
    public func saveExamResults (exam: ExamObject, passed: Bool) -> Bool {
        let realm = try! Realm()
        
        // Value can only be of type Boolean or of type string
        for (key, value) in self.results {
            let resultsObject = ResultsObject()
            resultsObject.resultKey = key;
            resultsObject.resultValue = value;
            do {
                try realm.write {
                    exam.resultList.append(resultsObject)
                }
            } catch {
                print("Unexpected error: \(error).")
                return false;
            }
        }
        
        do {
            try realm.write {
                realm.add(exam)
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
    @objc dynamic var type = "Pre-Trip Exam";
    @objc dynamic var examClass = "Class 1";
    @objc dynamic var status = "";
    @objc dynamic var form = "Form A";
    @objc dynamic var airBrakes = "False";
    @objc dynamic var vehicleAxles = "Two";
    @objc dynamic var trailerAxles = "Three";
    @objc dynamic var gvwr = "";
    @objc dynamic var passPoints = 0;
    
    let resultList = List<ResultsObject>();
}

class ResultsObject: Object {
    @objc dynamic var resultsId = "";
    @objc dynamic var resultKey = "";
    @objc dynamic var resultValue = "";
}
