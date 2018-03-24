//
//  ExamScheduleTableViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/18/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit
import RealmSwift

class ExamScheduleTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let vehicles = ["Vehicle A", "Vehicle B", "Vehicle C"]
    
    var exams:[ExamObject]! {
        willSet (newExamsList) {
            if newExamsList.count == 0 {
                self.showNoExamsView()
                self.tableView.isHidden = true
            } else {
                self.hideNoExamsView()
                self.tableView.isHidden = false
            }
        }
    }
    var menuViewController:ExamMenuTableViewController!
    var tableView:UITableView = UITableView()
    var noExamsView:UIView = UIView()
    
    func createNoExamsView () {
        let noResultsLabel = UILabel()
        noResultsLabel.text = "No Exams"
        noResultsLabel.font = UIFont.boldSystemFont(ofSize: 40)
        self.noExamsView.addSubview(noResultsLabel)
        self.noExamsView.backgroundColor = .white
        noResultsLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.noExamsView)
        }
        self.view.addSubview(self.noExamsView)
        self.noExamsView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.noExamsView.layer.zPosition = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = self.menuViewController.navigationController?.viewControllers.last as? ExamSectionsTableViewController {
            self.menuViewController.navigationController?.popToRootViewController(animated: true)
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNoExamsView()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.tableView.allowsSelection = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib.init(nibName: "ExamView", bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: "ExamViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeExam(with:)), name: .CDLExamFinished, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addExam(with:)), name: .CDLExamStarted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(examsChanged(with:)), name: .CDLExamsChanged, object: nil)
    }
    
    func showNoExamsView () {
        self.noExamsView.isHidden = false;
    }
    
    func hideNoExamsView () {
        self.noExamsView.isHidden = true;
    }
    
    @objc func examsChanged (with notification: Notification) {
        let exams = notification.userInfo!["exams"] as? [ExamObject]
        self.exams = exams
        self.tableView.reloadData()
    }
    
    @objc func removeExam (with notification: Notification) {
        let exam = notification.userInfo!["exam"] as? ExamObject
        if self.exams.index(of: exam!) != nil {
            self.exams.remove(at: self.exams.index(of: exam!)!)
            self.tableView.reloadData()
        }
    }
    
    @objc func addExam (with notification: Notification) {
        let exam = notification.userInfo!["exam"] as? ExamObject
        self.exams.append(exam!)
        self.tableView.reloadData()
    }

    @objc func refreshButtonPressed () {
        self.exams = ExamResults.sharedInstance.getExams(predicate: "cancelled == false && finished == false")
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exams.count;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExamViewCell", for: indexPath) as! ExamViewCell
        cell.setExam(exam: self.exams[indexPath.row])
        cell.startButton.addTarget(self, action: #selector(startExam(startButton:)), for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(cancelExam(cancelButton:)), for: .touchUpInside)
        cell.changeVehicle.addTarget(self, action: #selector(changeVehicle(changeVehicleButton:)), for: .touchUpInside)
        return cell
    }
    
    func updateVehicle (vehicle: String, exam: ExamObject) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                exam.vehicle = vehicle
            }
            
            return true
        } catch {
            print("Unexpected error: \(error).")
            return false
        }
    }
    
    @objc func changeVehicle (changeVehicleButton: UIButton) {
        let cell = changeVehicleButton.superview?.superview as! ExamViewCell;
        
        let alertController = UIAlertController(title: "Vehicle", message: "Select a Vehicle Type", preferredStyle: .actionSheet)
        for value in self.vehicles {
            let action = UIAlertAction(title: value, style: .default, handler: { (action) in
                if self.updateVehicle(vehicle: action.title!, exam: cell.exam) {
                    cell.vehicle.text = action.title!
                }
            })
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.popoverPresentationController?.sourceView = changeVehicleButton
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cancelExam (exam: ExamObject, indexPath: IndexPath, reason: String) {
        if ExamResults.sharedInstance.cancelExam(exam: exam, reason: reason) {
            self.exams.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

    @objc func cancelExam (cancelButton: UIButton) {
        let cell = cancelButton.superview?.superview as! ExamViewCell;
        
        let timeInterval = (cell.exam.date.timeIntervalSince(Date()) / 60)
        if timeInterval > 5 || timeInterval < -45  {
            // Create Conditions for this
            let alert = UIAlertController(title: "Reason", message: "Why are you cancelling this exam?", preferredStyle: .actionSheet)
            let noShowAction = UIAlertAction(title: "No Show", style: .default) { (action) in
                self.cancelExam(exam: cell.exam, indexPath: self.tableView.indexPath(for: cell)!, reason: kNoShow)
            }
            
            let clientRequestedAction = UIAlertAction(title: "Client Requested", style: .default) { (action) in
                self.cancelExam(exam: cell.exam, indexPath: self.tableView.indexPath(for: cell)!, reason: kClientRequested)
            }
            
            let weatherAction = UIAlertAction(title: "Weather", style: .default) { (action) in
                self.cancelExam(exam: cell.exam, indexPath: self.tableView.indexPath(for: cell)!, reason: kWeather)
            }
            
            let otherAction = UIAlertAction(title: "Other", style: .default) { (action) in
                let otherAlert = UIAlertController(title: "Other", message: "Why are you cancelling this exam?", preferredStyle: .alert)
                otherAlert.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = "Reason for cancelling"
                })
                self.present(otherAlert, animated: true, completion: nil)
                
                let cancelAction = UIAlertAction(title: "Don't Cancel Exam", style: .cancel, handler: nil)
                let okayAction = UIAlertAction(title: "Cancel Exam", style: .default, handler: { (action) in
                    let textField = otherAlert.textFields![0]
                    self.cancelExam(exam: cell.exam, indexPath: self.tableView.indexPath(for: cell)!, reason: textField.text!)
                })
                otherAlert.addAction(cancelAction)
                otherAlert.addAction(okayAction)
            }
            
            let cancelAction = UIAlertAction(title: "Don't Cancel Exam", style: .destructive, handler: nil)
            alert.addAction(noShowAction)
            alert.addAction(clientRequestedAction)
            alert.addAction(weatherAction)
            alert.addAction(otherAction)
            alert.addAction(cancelAction)
            alert.popoverPresentationController?.sourceView = cancelButton
            self.present(alert, animated: true, completion: nil)
        } else {
            let cannotCancelAlert = UIAlertController(title: "Cannot Cancel", message: "You can not cancel an exam less than 5 minutes before, or within 45 minutes after the scheduled start time", preferredStyle: .alert)
            cannotCancelAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(cannotCancelAlert, animated: true, completion: nil);
        }
        
    }
    
    @objc func startExam (startButton: UIButton) {
        let cell = startButton.superview?.superview as! ExamViewCell;
        ExamResults.sharedInstance.exam = cell.exam;
        let success = ExamResults.sharedInstance.startExam(exam: cell.exam)
        if !success {
            // -------------------------------------------- Handle Error -------------------------------------------------------
        }
        
        // Exam Sections
        let examSectionsTableViewController = ExamSectionsTableViewController();
        let result = UtilityFunctions.loadExam(form: cell.exam.form)
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
}
