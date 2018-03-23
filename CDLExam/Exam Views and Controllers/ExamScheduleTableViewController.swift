//
//  ExamScheduleTableViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/18/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamScheduleTableViewController: UITableViewController {

    var exams:[ExamObject]!;
    var menuViewController:ExamMenuTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        self.clearsSelectionOnViewWillAppear = false
        let nib = UINib.init(nibName: "ExamView", bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: "ExamViewCell")
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshButtonPressed))
        self.navigationItem.rightBarButtonItem = refreshButton
    }

    @objc func refreshButtonPressed () {
        self.exams = ExamResults.sharedInstance.loadExams()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exams.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExamViewCell", for: indexPath) as! ExamViewCell
        cell.setExam(exam: self.exams[indexPath.row])
        cell.startButton.addTarget(self, action: #selector(startExam(startButton:)), for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(cancelExam(cancelButton:)), for: .touchUpInside)
        return cell
    }
    
    @objc func cancelExam (cancelButton: UIButton) {
        let cell = cancelButton.superview?.superview as! ExamViewCell;
        // Create Conditions for this
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel the exam?", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            // Delete the exam
            let success = ExamResults.sharedInstance.deleteRealmObject(object: cell.exam)
            if !success {
                // Reveal to the client that there was an error saving realm
            } else {
                self.exams.remove(at: (self.tableView.indexPath(for: cell)?.row)!)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func startExam (startButton: UIButton) {
        let cell = startButton.superview?.superview as! ExamViewCell;
        ExamResults.sharedInstance.exam = cell.exam;
        // Exam Sections
        let examSectionsTableViewController = ExamSectionsTableViewController();
        examSectionsTableViewController.title = "Sections";
        
        let result = self.loadExam(form: cell.exam.form);
        examSectionsTableViewController.exam = result;
        var examSections = [String]();
        
        // Get the sections of the exam
        for (key, _) in result {
            examSections.append(key)
        }
        examSectionsTableViewController.examSections = examSections;
        
        // Create and show the Exam View Controller
        let examViewController = ExamCriteriaViewController();
        examViewController.exam = cell.exam
        examViewController.navigationController?.navigationBar.isHidden = false;
        examViewController.title = "Exam";
        examSectionsTableViewController.delegate = examViewController;
        self.navigationController?.pushViewController(examViewController, animated: true);
        self.menuViewController.navigationController?.pushViewController(examSectionsTableViewController, animated: false);
        
        examSectionsTableViewController.tableView(examSectionsTableViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0));
        
        // Update button to now say View Exam In Progress
        startButton.setTitle("Goto Exam", for: .normal);
    }
    
    func loadExam (form: String) -> [String:Any] {
        if let fileUrl = Bundle.main.url(forResource: "exam-criteria", withExtension: "plist"),
            // Load exam data
            let data = try? Data(contentsOf: fileUrl) {
            if var result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String:Any] {
                if form == kFormA {
                    result![kFormC] = nil;
                    result![kFormB] = nil;
                }
                return result!;
            }
        }
        
        // Handle Error, there should always be a result returned
        return [String:Any]();
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
