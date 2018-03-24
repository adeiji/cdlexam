//
//  ExamMenuTableViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/18/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamMenuTableViewController: UITableViewController {

    let kCreateExam = "Create Exam (Testing Purposes)"
    let kExamSchedule = "Exam Schedule"
    let kCompletedExams = "Completed Exams"
    let kCancelledExams = "Cancelled Exams"
    let kExamInProgress = "Exam In Progress Sections"
    let kSearchExams = "Search Exams"
    var menuItems:[String]!;
    
    var detailViewController:UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuItems = [self.kCreateExam, self.kExamSchedule, self.kCompletedExams, self.kCancelledExams, self.kExamInProgress, self.kSearchExams]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.menuItems[indexPath.row];
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If they click on exam in progress than we push the ExamSectionsTableViewController so they can view the exam info
        if menuItems[indexPath.row] == kCreateExam {
            let createExam = CreateExamViewController(nibName: "CreateExamView", bundle: nil)
            if let _ = self.detailViewController.viewControllers.last as? CreateExamViewController {
            } else {
                self.detailViewController.popToRootViewController(animated: false)
                self.detailViewController.pushViewController(createExam, animated: true)
            }
        } else if menuItems[indexPath.row] == kCompletedExams {
            let exams = ExamResults.sharedInstance.getExams(predicate: "finished == true")
            self.detailViewController.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: .CDLExamsChanged, object: self, userInfo: ["exams": exams])
        } else if menuItems[indexPath.row] == kCancelledExams {
            self.detailViewController.popToRootViewController(animated: true)
            let exams = ExamResults.sharedInstance.getExams(predicate: "cancelled == true")
            NotificationCenter.default.post(name: .CDLExamsChanged, object: self, userInfo: ["exams": exams])
        } else if menuItems[indexPath.row] == kExamSchedule {
            self.detailViewController.popToRootViewController(animated: true)
            let exams = ExamResults.sharedInstance.getExams(predicate: "finished == false && cancelled == false")
            NotificationCenter.default.post(name: .CDLExamsChanged, object: self, userInfo: ["exams": exams])
        } else if menuItems[indexPath.row] == kSearchExams {
            let search = ExamSearchViewController(nibName: "ExamSearch", bundle: nil)
            if let _ = self.detailViewController.viewControllers.last as? ExamSearchViewController {
            } else {
                self.detailViewController.popToRootViewController(animated: false)
                self.detailViewController.pushViewController(search, animated: true)
            }
            
        } else if menuItems[indexPath.row] == kExamInProgress {
            // Create and show the Exam View Controller
            if ExamResults.sharedInstance.exam?.finished == false {
                let examViewController = ExamCriteriaViewController();
                examViewController.exam = ExamResults.sharedInstance.exam
                examViewController.navigationController?.navigationBar.isHidden = false;
                examViewController.title = "Exam";
                
                // Exam Sections
                let examSectionsTableViewController = ExamSectionsTableViewController();
                let result = UtilityFunctions.loadExam(form: ExamResults.sharedInstance.exam.form)
                examSectionsTableViewController.exam = result;
                var examSections = [String]();
                
                // Get the sections of the exam
                for (key, _) in result {
                    examSections.append(key)
                }
                examSectionsTableViewController.examSections = examSections;
                examSectionsTableViewController.delegate = examViewController;
                
                if let _ = self.detailViewController.viewControllers.last as? ExamCriteriaViewController {
                } else {
                    self.detailViewController.popToRootViewController(animated: false)
                    self.detailViewController.pushViewController(examViewController, animated: false)
                }
                
                if let _ = self.navigationController?.viewControllers.last as? ExamSectionsTableViewController {
                } else {
                    self.navigationController?.pushViewController(examSectionsTableViewController, animated: false)
                    examSectionsTableViewController.tableView(examSectionsTableViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0));
                }
                
            }
            
        }
        // Exam In Progress will take you to the current exam that is being worked on
    }
}
