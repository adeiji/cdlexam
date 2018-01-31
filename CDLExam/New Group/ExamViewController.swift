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
    var examSections = [String]();
    var selectedIndexPaths = [IndexPath]();
    
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
            let vehicleInfoCell = Bundle.main.loadNibNamed("ExamViewController", owner: self, options: nil)?.first as! UITableViewCell
            return vehicleInfoCell;
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
            tableView.reloadRows(at: self.selectedIndexPaths, with: .fade)
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
