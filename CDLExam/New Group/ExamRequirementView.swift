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
    @IBOutlet weak var headerDescription: UILabel!
    
    var sections = [ExamSection]()
    
    func addSection (section: ExamSection) {
        sections.append(section)
    }
    
    func layoutSections () {
        var sectionAbove:ExamSection!
        for section in sections {
            self.contentView.addSubview(section)
            section.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView).offset(section.level * 15)
                if section == sections.first {
                    make.top.equalTo(self.headerDescription.snp.bottom)
                } else {
                    make.top.equalTo(sectionAbove.snp.bottom)
                }
                
                if section == sections.last {
                    make.bottom.equalTo(self.contentView)
                }
                make.right.equalTo(self.contentView)
            }
            sectionAbove = section;
        }
    }
    
}

class ExamSection : UIView {
    
    @IBOutlet weak var header: UILabel!
    
    var level:Int!
    
    func addRequirements (criteriaViews: [ExamCriteriaView]) {
        
        var index = 0;
        for criteriaView in criteriaViews {
            self.addSubview(criteriaView)
            criteriaView.snp.makeConstraints({ (make) in
                if index == 0 {
                    make.top.equalTo(self.header.snp.bottom).offset(10)
                } else {
                    make.top.equalTo(criteriaViews[index - 1].snp.bottom)
                }
                // Last Item
                if index == criteriaViews.count - 1 {
                    make.bottom.equalTo(self).offset(-15)
                }
                
                make.right.equalTo(self)
                make.left.equalTo(self)
            })
            
            index = index + 1
        }
    }
    
}

class ExamCriteriaView: UIView {
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    
    var textField:UITextField!
    var segment:UISegmentedControl!
    var mySwitch:UISwitch!
    
    func setup(type: String) {        
        switch type {
        case "CONTROL":
            self.segment = UISegmentedControl()
            self.addSubview(self.segment)
            self.segment.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-30)
                make.height.equalTo(30)
            });
        case "INPUT":
            self.textField = UITextField()
            self.addSubview(self.textField)
            self.textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-30)
                make.height.equalTo(30)
            })
        case "SWITCH":
            self.mySwitch = UISwitch()
            self.addSubview(mySwitch)
            self.mySwitch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.height.equalTo(30)
            })
        default:break
        }
    }
    
  
}
