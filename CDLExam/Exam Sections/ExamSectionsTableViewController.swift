//
//  ExamSectionsTableViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/16/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamSectionsTableViewController: UITableViewController {

    var examSections = [String]()
    var examSectionHeaders = [String]()
    var exam = [String:Any]()
    var delegate: LoadExamInfoDelegate?
    var resultKey:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examSections.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = self.examSections[indexPath.row];
        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var resultKey = "";
        if self.resultKey != "" {
            resultKey = self.resultKey + "." + self.examSections[indexPath.row]
        } else {
            resultKey = self.examSections[indexPath.row]
        }
        
        
        // Send a notification that a section has been clicked with the data for that section
        if let values = self.exam[self.examSections[indexPath.row]] as? [String] {
            // Values is an array meaning that we've got values only
            if (self.delegate != nil) {
                self.delegate?.loadExamDetailsArray(info: values, header: self.examSections[indexPath.row], resultKey: resultKey);
            }
        } else if let values = self.exam[self.examSections[indexPath.row]] as? [String:[String:Any]] {
            let viewController = ExamSectionsTableViewController();
            for (key, _) in values {
                viewController.examSections.append(key);
            }
            viewController.delegate = self.delegate;
            viewController.exam = self.exam[self.examSections[indexPath.row]] as! [String : Any];
            viewController.resultKey = resultKey;
            self.navigationController?.pushViewController(viewController, animated: true);
        } else if let values = self.exam[self.examSections[indexPath.row]] as? [String:Any] {
            // Value is a dictionary
            if (self.delegate != nil) {
                let keys = Array(values.keys)
                self.delegate?.loadExamDetailsDictionary(info: values, headers: keys, resultKey: resultKey);
            }
        }
    }
}
