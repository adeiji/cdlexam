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
        
        do {
            let realm = try Realm()
            try realm.write {
                let resultObject = ResultsObject()
                resultObject.resultKey = key
                resultObject.resultValue = value
                self.exam.resultList.append(resultObject)
            }
        } catch {
            print("Unexpected error: \(error).")
        }
        
    }
    
    public func getResult (key: String) -> String? {
        return self.results[key];
    }
    
    public func setResults (exam: ExamObject){
        self.results = [String:String]();
        for result in exam.resultList {
            self.results[result.resultKey] = result.resultValue;
        }
    }
    
    public func startExam(exam: ExamObject) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                exam.started = true;
            }
            return true
        } catch {
            print("Unexpected error: \(error).")
            return false
        }
    }
    
    public func endExam(exam: ExamObject) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                exam.started = true;
            }
            return true
        } catch {
            print("Unexpected error: \(error).")
            return false;
        }
    }
    
    public func cancelExam (exam: ExamObject, reason: String) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                exam.cancelled = true;
                exam.cancelReason = reason
            }
        } catch {
            print("Unexpected error: \(error).")
            return false;
        }
        
        return true
    }
    
    
    public func getExams (predicate: Any) -> [ExamObject] {
        do {
            let realm = try Realm()
            if let stringPredicate = predicate as? String {
                let exams = realm.objects(ExamObject.self).filter(stringPredicate)
                return Array(exams);
            } else {
                let exams = realm.objects(ExamObject.self).filter(predicate as! NSPredicate)
                return Array(exams);
            }
            
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return [ExamObject]();
    }
    
    public func saveExamResults (exam: ExamObject, passed: Bool) -> Bool {
        let realm = try! Realm()
        var passedCount = 0;
        do {
            try realm.write {
                if exam.resultList.count > 0 {
                    // Reset the list and input all new information
                    exam.resultList.removeAll()
                }
                for (key, value) in self.results {
                    let resultsObject = ResultsObject()
                    resultsObject.resultKey = key;
                    resultsObject.resultValue = value;
                    if UtilityFunctions.toBool(value: value) {
                        passedCount = passedCount + 1
                    }
                    
                    exam.resultList.append(resultsObject)
                }
                if passedCount >= exam.passPoints {
                    exam.passed = true
                }
                exam.finished = true;
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
    @objc dynamic var started = false;
    @objc dynamic var finished = false;
    @objc dynamic var passed = false;
    @objc dynamic var cancelled = false;
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
    @objc dynamic var cancelReason = "";
    
    let resultList = List<ResultsObject>();
}

class ResultsObject: Object {
    @objc dynamic var resultsId = "";
    @objc dynamic var resultKey = "";
    @objc dynamic var resultValue = "";
}
