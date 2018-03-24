//
//  ExamSearchViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/22/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit

class ExamSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var examSearchView: ExamSearchView!
    var fromDate:Date!
    var toDate:Date!
    var searchButtonPressed = false;
    var results:[ExamObject] = [ExamObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func updateSearchResults(for searchController: UISearchController) {
        // Get Status
        var index = self.examSearchView.examStatusSegment.selectedSegmentIndex
        let status = self.examSearchView.examStatusSegment.titleForSegment(at: index)
        // Get Client
        index = self.examSearchView.examClassSegment.selectedSegmentIndex
        let examClass = self.examSearchView.examClassSegment.titleForSegment(at: index)

        var predicate = ""
        var params = [Any]();
        
        if self.examSearchView.reschedulingSwitch.isOn {
            predicate = "(finished == %@ && passed == %@) OR (cancelled == %@)"
            
            params.append(NSNumber(value: true))
            params.append(NSNumber(value: false))
            params.append(NSNumber(value: true))
        } else {
            switch status! {
            case "Started":
                predicate = "started == %@ && cancelled == %@"
                params.append(NSNumber(value: true))
                params.append(NSNumber(value: false))
                break;
            case "Finished":
                predicate = "finished == %@"
                params.append(NSNumber(value: true))
                break;
            case "Cancelled":
                predicate = "cancelled == %@"
                params.append(NSNumber(value: true))
                break;
            default:break;
            }
        }
        
        switch examClass! {
        case "Class 1":
            predicate = predicate + " && examClass == %@"
            params.append("Class 1")
            break;
        case "Class B":
            predicate = predicate + " && examClass == %@"
            params.append("Class B")
            break;
        default: break;
        }
        
        if self.fromDate != nil {
            predicate = predicate + " && date > %@"
            params.append(self.fromDate!)
            
        }
        if self.toDate != nil {
            predicate = predicate + " && date < %@"
            params.append(self.toDate!)
        }
        
        
        if self.searchButtonPressed == false {
            if self.searchBarIsEmpty() == false {
                var subPredicate = ""
                if self.examSearchView.licenseSwitch.isOn {
                    subPredicate = subPredicate + " OR license CONTAINS %@"
                    params.append(self.searchController.searchBar.text!)
                }
                if self.examSearchView.clientNameSwitch.isOn {
                    subPredicate = subPredicate + " OR name CONTAINS %@"
                    params.append(self.searchController.searchBar.text!)
                }
                if self.examSearchView.examinerSwitch.isOn {
                    subPredicate = subPredicate + " OR examiner CONTAINS %@)"
                    params.append(self.searchController.searchBar.text!)
                }
                // If none of the switches are clicked than we simply search by everything.
                // We will need to add examiner to this list soon
                if subPredicate == "" {
                    subPredicate = "license CONTAINS %@ OR name CONTAINS %@"
                    params.append(self.searchController.searchBar.text!)
                    params.append(self.searchController.searchBar.text!)
                }
                
                subPredicate = subPredicate.trimmingCharacters(in: .init(charactersIn: " OR"))
                if predicate != "" {
                    predicate = predicate + " && (" + subPredicate + ")"
                } else {
                    predicate = predicate + "(" + subPredicate + ")"
                }
                
            }
        }
        
        predicate = predicate.trimmingCharacters(in: .init(charactersIn: " &&"))
        if predicate != "" {
            self.results = ExamResults.sharedInstance.getExams(predicate: NSPredicate(format: predicate, argumentArray:params))
            self.tableView.reloadData()
            // Detect if this method is being called because the Search button was pressed or the user has entered information
            // into the search bar
            self.examSearchView.fromDateTextField.resignFirstResponder()
            self.examSearchView.toDateTextField.resignFirstResponder()
        }
        self.searchButtonPressed = false;
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        // So that the controller knows that we're updating because the user pressed the search button not because of a change
        // in the search bar text
        searchButtonPressed = true
        self.updateSearchResults(for: self.searchController)
    }
    func searchBarIsEmpty () -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func setupDatePickers () {
        let from = UIDatePicker()
        from.datePickerMode = .date
        from.addTarget(self, action: #selector(fromDatePickerChanged(picker:)), for: .valueChanged)
        
        let to = UIDatePicker()
        to.datePickerMode = .date
        to.addTarget(self, action: #selector(toDatePickerChanged(picker:)), for: .valueChanged)
        
        self.examSearchView.fromDateTextField.inputView = from
        self.examSearchView.toDateTextField.inputView = to
    }
    
    @objc func fromDatePickerChanged (picker: UIDatePicker) {
        self.fromDate = picker.date
        self.examSearchView.fromDateTextField.text = UtilityFunctions.dateToString(date: picker.date, style: .short)
    }
    
    @objc func toDatePickerChanged (picker: UIDatePicker) {
        self.toDate = picker.date
        self.examSearchView.toDateTextField.text = UtilityFunctions.dateToString(date: picker.date, style: .short)
    }
    
    @IBAction func clearDatesPressed(_ sender: UIButton) {
        self.examSearchView.fromDateTextField.text = "";
        self.examSearchView.toDateTextField.text = "";
        self.fromDate = nil;
        self.toDate = nil;
    }
    
    @objc func filterByReschedulingNeededPressed (button: UIBarButtonItem) {
        self.results = ExamResults.sharedInstance.getExams(predicate: "cancelled == true OR (passed == false AND finished == true)")
        self.tableView.reloadData()
        // Detect if this method is being called because the Search button was pressed or the user has entered information
        // into the search bar
        self.examSearchView.fromDateTextField.resignFirstResponder()
        self.examSearchView.toDateTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ExamResults.sharedInstance.getExams(predicate: "cancelled == true OR (passed == false AND finished == true)").count > 0 {
            let needsReschulingButton = UIBarButtonItem(title: "Rescheduling Needed", style: .plain, target: self, action: #selector(filterByReschedulingNeededPressed(button:)))
            self.navigationItem.rightBarButtonItem = needsReschulingButton;
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Data"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.setupDatePickers()
        let nib = UINib.init(nibName: "ExamView", bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: "ExamViewCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExamViewCell", for: indexPath) as! ExamViewCell
        cell.setExam(exam: self.results[indexPath.row])
        cell.schedulePageButton.isHidden = false
//        cell.startButton.addTarget(self, action: #selector(startExam(startButton:)), for: .touchUpInside)
//        cell.cancelButton.addTarget(self, action: #selector(cancelExam(cancelButton:)), for: .touchUpInside)
        return cell
    }
    
}

class ExamSearchView: UIView {
    
    @IBOutlet weak var licenseSwitch: UISwitch!
    @IBOutlet weak var clientNameSwitch: UISwitch!
    @IBOutlet weak var examinerSwitch: UISwitch!
    @IBOutlet weak var reschedulingSwitch: UISwitch!
    
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var examClassSegment: UISegmentedControl!
    @IBOutlet weak var examStatusSegment: UISegmentedControl!
    
}
