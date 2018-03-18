//
//  ExamViewController.swift
//  CDLExam
//
//  Created by adeiji on 1/29/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamViewController: UITableViewController, LoadExamInfoDelegate {
    
    var requirements = [String:Any]()
    let kRequireAllSessions = "REQUIRES ALL SESSIONS", kHeader = "HEADER", kInput = "INPUT", kVehicleInfo = "Vehicle Info"
    let kTypeControl = "CONTROL", kTypeInput = "INPUT", kTypeSwitch = "SWITCH"
    var selectedIndexPaths = [IndexPath]();
    var criteriaList = [String]()
    var criteriaDict = [String:Any]();
    var tableViewHeaders = [String]()
    var resultKey:String!
    
    func reset() {
        self.criteriaDict = [String:Any]();
        self.criteriaList = [String]();
        self.tableViewHeaders = [String]();
    }
    
    func loadExamDetailsArray(info: [String], header: String, resultKey: String) {
        reset();
        self.criteriaList = info;
        self.tableViewHeaders.append(header);
        self.resultKey = resultKey;
        self.tableView.reloadData();
    }
    
    func loadExamDetailsDictionary(info: [String : Any], headers: [String], resultKey: String) {
        reset();
        self.criteriaDict = info;
        self.tableViewHeaders = headers;
        self.resultKey = resultKey;
        self.tableView.reloadData();
    }
    
    struct Result {
        var totalRequirements:Int!
        var numberCorrect:Int!
    }
    
    struct Requirement {
        var type: String?
        var name: String?
        var values: [String]?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the table view our main view
        self.tableView.separatorStyle = .none;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.tableViewHeaders.count != 0) {
            return self.tableViewHeaders[section];
        } else {
            return nil;
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.criteriaList.count != 0) {
            return self.criteriaList.count;
        } else if (self.criteriaDict.keys.count != 0) {
            // If the values for this specific key are of type Array
            if let values = self.criteriaDict[self.tableViewHeaders[section]] as? [String] {
                return values.count;
            } else {
                if let _ = self.criteriaDict[self.tableViewHeaders[section]] as? [String:Any] { // If this is an array of dic
                    return 1
                } else {
                    if let array = self.criteriaDict[self.tableViewHeaders[section]] as? [Any] {
                        return array.count;
                    }
                }
            }
        }
        
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExamCriteriaView();
        let section = self.tableViewHeaders[indexPath.section];
        
        if (self.criteriaList.count != 0) {
            cell.setup(type: "SWITCH", key: self.resultKey + "." + section + "." + self.criteriaList[indexPath.row])
            cell.nameLabel!.text = self.criteriaList[indexPath.row];
        } else {
            if let values = self.criteriaDict[self.tableViewHeaders[indexPath.section]] as? [String] {
                let resultKey = self.resultKey + "." + section + "." + values[indexPath.row];
                cell.setup(type: "SWITCH", key: resultKey)
                cell.nameLabel.text = values[indexPath.row]
            } else {
                if let values = self.criteriaDict[self.tableViewHeaders[indexPath.section]] as? [String:Any] {
                    for (key, value) in values {
                        let multipleChoiceView = MultipleChoiceView();
                        multipleChoiceView.setup(headerName: key, criteriaList: value as! [String])
                        multipleChoiceView.resultKey = key;
                        return multipleChoiceView;
                    }
                } else {
                    if let values = self.criteriaDict[self.tableViewHeaders[indexPath.section]] as? [Any] {
                        if let value = values[indexPath.row] as? String {
                            let resultKey = self.resultKey + "." + section + "." + value;
                            cell.setup(type: "SWITCH", key: resultKey)
                            cell.nameLabel.text = value;
                        } else {
                            if let value = values[indexPath.row] as? [String: Any] {
                                for (key, value) in value {
                                    let multipleChoiceView = MultipleChoiceView();
                                    multipleChoiceView.setup(headerName: key, criteriaList: value as! [String])
                                    multipleChoiceView.resultKey = key;
                                    return multipleChoiceView;
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
