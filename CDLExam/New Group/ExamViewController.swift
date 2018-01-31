//
//  ExamViewController.swift
//  CDLExam
//
//  Created by adeiji on 1/29/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requirements = [String:Any]()
    let kRequireAllSessions = "REQUIRES ALL SESSIONS", kHeader = "HEADER", kInput = "INPUT", kVehicleInfo = "Vehicle Info"
    let kTypeControl = "CONTROL", kTypeInput = "INPUT", kTypeSwitch = "SWITCH"
    var tableCells = [IndexPath:UITableViewCell]()
    var examSections = [String]();
    var selectedIndexPaths = [IndexPath]();
    
    struct Requirement {
        var type: String?
        var name: String?
        var values: [String]?;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fileUrl = Bundle.main.url(forResource: "exam-criteria", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String:Any] {
                self.requirements = result!
                for (key, _) in self.requirements {
                    examSections.append(key);
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requirements.keys.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.selectedIndexPaths.contains(indexPath)) {
            return self.tableCells[indexPath]!
            
        } else {
            let cell = UITableViewCell();
            
            cell.textLabel?.text = self.examSections[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
            
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath);
        if selectedCell?.textLabel?.text == kVehicleInfo {
            self.selectedIndexPaths.append(indexPath);
            self.tableCells[indexPath] = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)?.first as? UITableViewCell
            tableView.reloadRows(at: self.selectedIndexPaths, with: .fade)
        }
    }
    
    func createVehicleInfoScreen (requirements: [String]) -> UIView {
        let vehicleInfoView = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)?.first as! ExamRequirementView
        vehicleInfoView.header.text = "Vehicle Info"
        vehicleInfoView.sectionDescription.text = "Default values from vehicle configuration"
        
        for requirementString in requirements {
            let requirement = self.getRequirementInfo(requirement: requirementString) as Requirement
            if requirement.type == kTypeControl {
                let view = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)![1] as! ExamCriteriaView
                var counter = 0;
                for value in requirement.values! {
                    view.segment.insertSegment(withTitle: value, at: counter, animated: true)
                    counter++;
                }
            }
        }
        
        return UIView()
    }
    
    /**
     * - Description Takes a requirement string and seperates it into specific parameters, ex: "Safety Belt|CONTROL:YES/NO"
     
     * - Parameter requirement - A string containing the requirement name, type, and values
     * - Returns Requirement object - A custom struct that consists of necessary parameters to base view creation off of
     */
    func getRequirementInfo (requirement: String) -> Requirement {
        var name:String!
        
        if requirement.contains("|")  {
            var endOfDetailsIndex = requirement.index(of: "|") as! String.Index
            name = String(requirement[..<endOfDetailsIndex])
            endOfDetailsIndex = requirement.index(endOfDetailsIndex, offsetBy: 1)
            let details = String(requirement[endOfDetailsIndex...]);
            let optionsList = details.split(separator: ":").last
            var optionStrings = [String]()
            if (optionsList!.contains("/")) {
                let options = optionsList?.split(separator: "/")
                for string in options! {
                    optionStrings.append(String(string))
                }
            } else {
                optionStrings.append(String(describing: optionsList!))
            }
            
            let requirementInfo = Requirement(type: String(describing: details.split(separator: ":").first!), name: name, values: optionStrings)
            return requirementInfo
        } else {
            return Requirement(type:kTypeSwitch, name: requirement, values: nil);
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
