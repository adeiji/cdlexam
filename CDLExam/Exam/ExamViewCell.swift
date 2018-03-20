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
    var exam:Exam!
    
    func setExam (exam: Exam) {
        self.exam = exam;
        self.name.text = exam.name;
        self.date.text = "Monday 2/25/2018 @ 9:20 PM";
        self.license.text = exam.driversLicense;
        self.vehicle.text = exam.vehicle;
        self.type.text = exam.type;
        self.examClass.text = exam.examClass;
    }
}
