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
        self.selectedIndexPaths.append(indexPath);
        let key = (selectedCell?.textLabel?.text)!
        let infoView = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)?.last as! ExamRequirementView
        infoView.header.text = key;
        let examSection = self.getExamSection(infoView: infoView, requirementKey: key, dictionary: self.requirements, level: 1)
        examSection.layoutSections()
        self.tableCells[indexPath] = examSection;
        tableView.reloadRows(at: self.selectedIndexPaths, with: .fade)
    }
    
    func addRequirements (requirements: [String], section: ExamSection) -> ExamSection {
        
        var criteriaView:ExamCriteriaView!
        var criteriaViewList = [ExamCriteriaView]()
        for requirementString in requirements {
            // Create view or requirement type
            let requirement = self.getRequirementInfo(requirement: requirementString) as Requirement
            criteriaView = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)!.first as! ExamCriteriaView
            criteriaView.nameLabel.text = requirement.name
            criteriaView.setup(type: requirement.type!)
            
            if requirement.type == kTypeControl {
                var counter = 0;
                for value in requirement.values! {
                    criteriaView.segment.insertSegment(withTitle: value, at: counter, animated: true)
                    counter = counter + 1;
                }
            } else if requirement.type == kTypeInput {
                criteriaView.textField.placeholder = requirement.name
            }
            
            criteriaViewList.append(criteriaView)
        }
        
        section.addRequirements(criteriaViews: criteriaViewList)
        return section
    }
    
    /**
     * - Description Creates an entire exam section based off of self.requirements key value
     * - Parameter requirementKey - The key for the value in self.requirements
     * - Parameter dictionary - The dictionary value in which to get the key value pair
     * - Parameter level - The section level, is it a subsection? Level 0 is base, level 1 is one section level down and so on
     * - Returns ExamRequirementView
     */
    func getExamSection (infoView: ExamRequirementView, requirementKey: String, dictionary: [String:Any]!, level: Int) -> ExamRequirementView {
        var myInfoView = infoView;
        let value = dictionary[requirementKey]
        var examSection = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)?[1] as! ExamSection
        examSection.header.text = requirementKey
        examSection.level = level;
        
        // Check if the value for this key is an array or a dictionary
        if value is Dictionary<String, Any> {
            // Create Section
            for (key, _) in value as! [String: Any] {
                myInfoView = self.getExamSection(infoView: myInfoView, requirementKey: key, dictionary: value as! [String : Any], level: level + 1)
            }
            
        } else if value is [String] {
            // Handle Requirements
            examSection = self.addRequirements(requirements: value as! [String], section: examSection)
        }
        
        myInfoView.addSection(section: examSection)
        return myInfoView
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
