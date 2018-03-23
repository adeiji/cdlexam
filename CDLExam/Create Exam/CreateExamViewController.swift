//
//  CreateExamViewController.swift
//  CDLExam
//
//  Created by adeiji on 3/21/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CreateExamViewController : UIViewController {
    
    let examObject = ExamObject();
    @IBOutlet var createExamView: CreateExamView!
    
    override func viewDidLoad() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        self.createExamView.examTimeTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged(picker:)), for: .valueChanged)
    }
    
    @objc func dateChanged (picker: UIDatePicker) {
        self.createExamView.examTimeTextField.text = UtilityFunctions.dateToString(date: picker.date)
        self.examObject.date = picker.date
    }
    
    @IBAction func examTypeSelected(_ sender: UISegmentedControl) {
        self.examObject.type = sender.titleForSegment(at: sender.selectedSegmentIndex)!;
    }
    @IBAction func formTypeSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.examObject.form = kFormA
        } else if sender.selectedSegmentIndex == 1 {
            self.examObject.form = kFormB
        } else {
            self.examObject.form = kFormC
        }
    }
    @IBAction func busSwitchChanged(_ sender: UISwitch) {
        
    }
    @IBAction func onSiteSwitchChanged(_ sender: UISwitch) {
        
    }

    @IBAction func vehicleAxlesChanged(_ sender: UISegmentedControl) {
        self.examObject.vehicleAxles = sender.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    @IBAction func trailerAxlesChanged(_ sender: UISegmentedControl) {
        self.examObject.trailerAxles = sender.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    @IBAction func airBrakesSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.examObject.airBrakes = "True"
        } else {
            self.examObject.airBrakes = "False"
        }
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        self.examObject.passPoints = Int(sender.value)
        self.createExamView.pointsToPassTextField.text = String(sender.value)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        self.examObject.name = self.createExamView.clientNameTextField.text!;
        self.examObject.clientId = self.createExamView.clientNumberTextField.text!
        self.examObject.license = self.createExamView.licenseNumberTextField.text!
        self.examObject.gvwr = self.createExamView.gvwrTextField.text!
        self.examObject.passed = false;
        self.examObject.vehicle = "N/A"
        self.examObject.status = "Not Started"
        self.examObject.examClass = "N/A"
        
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(examObject)
            }
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print ("Unexpected error: \(error).")
        }
    }
}
