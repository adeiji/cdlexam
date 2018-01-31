//
//  ExamRequirementView.swift
//  CDLExam
//
//  Created by adeiji on 1/31/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import UIKit
import SnapKit

class ExamRequirementView: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var sectionDescription: UILabel!
    @IBOutlet weak var line: UIView!
    
}

class ExamCriteriaView: UIView {
        
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var divider: UIView!
    
    weak var textField:UITextField!
    weak var segment:UISegmentedControl!
    weak var mySwitch:UISwitch!
    
    init(type: String) {
        super.init(frame: .zero)
        
        switch type {
        case "CONTROL":
            self.segment = UISegmentedControl()
            self.addSubview(self.segment)
            self.segment.snp.makeConstraints({ (make) in
                make.left.equalTo(self.divider.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(30)
                make.height.equalTo(30)
            });
        case "INPUT":
            self.textField = UITextField()
            self.addSubview(self.textField)
            self.textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.divider.snp.right)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(30)
                make.height.equalTo(30)
            })
        case "SWITCH":
            self.mySwitch = UISwitch()
            self.addSubview(mySwitch)
            self.mySwitch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.divider.snp.right)
                make.centerY.equalTo(self)
                make.height.equalTo(30)
            })
        default:break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
