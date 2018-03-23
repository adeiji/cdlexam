//
//  ExamViewCell.swift
//  CDLExam
//
//  Created by adeiji on 3/18/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation
import UIKit

class ExamViewCell : UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var vehicle: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var examClass: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var changeVehicle: UIButton!
    
    var exam:ExamObject!
    
    func setExam (exam: ExamObject) {
        self.exam = exam;
        self.name.text = exam.name;
        self.date.text = UtilityFunctions.dateToString(date: exam.date)
        self.license.text = exam.license;
        self.vehicle.text = exam.vehicle;
        self.type.text = exam.type;
        self.examClass.text = exam.examClass;
        
        if exam.started == true {
            self.startButton.setTitle("Goto Exam", for: .normal)
        } else {
            self.startButton.setTitle("Start Exam", for: .normal)
        }
        
        if exam.finished == true || exam.cancelled == true {
            self.startButton.isHidden = true
            self.cancelButton.isHidden = true
            self.changeVehicle.isHidden = true
        } else {
            self.startButton.isHidden = false
            self.cancelButton.isHidden = false
            self.changeVehicle.isHidden = false
        }
    }
}
