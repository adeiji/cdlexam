//
//  ExamViewController.swift
//  CDLExam
//
//  Created by adeiji on 1/29/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit
import PDFGenerator

class ExamCriteriaViewController: UITableViewController, LoadExamInfoDelegate, UIDocumentInteractionControllerDelegate {
    
    var requirements = [String:Any]()
    let kRequireAllSessions = "REQUIRES ALL SESSIONS", kHeader = "HEADER", kInput = "INPUT", kVehicleInfo = "Vehicle Info"
    let kTypeControl = "CONTROL", kTypeInput = "INPUT", kTypeSwitch = "SWITCH"
    var selectedIndexPaths = [IndexPath]();
    var criteriaList = [String]()
    var criteriaDict = [String:Any]();
    var tableViewHeaders = [String]()
    var resultKey:String!
    var exam:Exam!
    var documentInteractionController:UIDocumentInteractionController!
    
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
        
        // Add finish button
        let finishButton = UIBarButtonItem(title: "End Exam", style: .done, target: self, action: #selector(endExam));
        self.navigationItem.rightBarButtonItem = finishButton;
        // Make the table view our main view
        self.tableView.separatorStyle = .none;
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    /**
     * - Description Prompt the user to end the exam
     * - Returns nil
     */
    @objc func endExam () {
        // Show Action Box
        let alert = UIAlertController(title: "Are you sure?", message: "Is this exam finished?", preferredStyle: .alert);
        let okayAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            // Save the exam and display exam results
            let didSave = ExamResults.sharedInstance.saveExamResults(exam: self.exam, passed: true)
            if didSave {
                let viewController = UIViewController()
                let width = viewController.view.frame.width;
                let pdfView = UIView(frame: CGRect(x: 0, y: 0, width: Int(width), height: 2000))
                var yPos = 0;
                var xPos = 13;
                let header = PDFHeader(frame: CGRect(x: 0, y: 0, width: width, height: 180))
                yPos = yPos + 180;
                
                let allVehicles = PDFAllVehiclesSection(frame: CGRect(x: 0, y: yPos, width: Int(width), height: 167))
                yPos = yPos + 167
                
                let allCombinationVehicles = PDFAllCombinationVehiclesSection(frame: CGRect(x: 0, y: yPos, width: Int(width), height: 234))
                yPos = yPos + 234
                
                let formA = PDFFormASection(frame: CGRect(x: xPos, y: yPos, width: 181, height: 629))
                xPos = xPos + 181
                
                let formB = PDFFormBSection(frame: CGRect(x: xPos, y: yPos, width: 181, height: 674))
                xPos = xPos + 181
                
                let formC = PDFFormCSection(frame: CGRect(x: xPos, y: yPos, width: 181, height: 655))
                xPos = xPos + 181
                
                let allPassengerVehicles = PDFAllPassengerVehiclesSection(frame: CGRect(x: xPos, y: yPos, width: 181, height: 357))
                xPos = 0;
                
                header.clearsContextBeforeDrawing = false;
                allVehicles.clearsContextBeforeDrawing = false;
                allCombinationVehicles.clearsContextBeforeDrawing = false;
                formA.clearsContextBeforeDrawing = false;
                formB.clearsContextBeforeDrawing = false;
                formC.clearsContextBeforeDrawing = false;
                allPassengerVehicles.clearsContextBeforeDrawing = false;
                
                header.backgroundColor = .white;
                allVehicles.backgroundColor = .white
                allCombinationVehicles.backgroundColor = .white
                formA.backgroundColor = .white
                formB.backgroundColor = .white
                formC.backgroundColor = .white
                allPassengerVehicles.backgroundColor = .white
                
                pdfView.addSubview(header)
                pdfView.addSubview(allVehicles)
                pdfView.addSubview(allCombinationVehicles)
                pdfView.addSubview(formA)
                pdfView.addSubview(formB)
                pdfView.addSubview(formC)
                pdfView.addSubview(allPassengerVehicles)
                
                self.generatePDF(view: pdfView)
            } else {
                // Handle error showing that the exam did not save
            }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(okayAction);
        alert.addAction(cancelAction);
        
        self.present(alert, animated: true, completion: nil);
    }

    func generatePDF (view: UIView) {
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: [view])
            try! data.write(to: dst, options: .atomic)
            self.documentInteractionController = UIDocumentInteractionController.init(url: dst);
            self.documentInteractionController.delegate = self;
            self.documentInteractionController.presentPreview(animated: true)
            
        } catch (let error) {
            print(error)
        }
        
        
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
                if let _ = self.criteriaDict[self.tableViewHeaders[section]] as? [String:Any] { // If this is an array of dictionaries
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
            cell.setup(type: "SWITCH", key: self.resultKey + "." + self.criteriaList[indexPath.row])
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
