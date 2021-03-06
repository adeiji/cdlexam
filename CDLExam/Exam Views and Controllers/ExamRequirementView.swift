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
                make.left.equalTo(self.contentView)
                if section == sections.first {
                    make.top.equalTo(self.headerDescription.snp.bottom).offset(20)
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
    var passedCount = 0
    var totalRequirementsCount:Int!
    var section:String = ""
    
    func addRequirements (criteriaViews: [ExamCriteriaView]) {
        
        var index = 0;
        self.totalRequirementsCount = criteriaViews.count
        for criteriaView in criteriaViews {
            if criteriaView.mySwitch != nil {
                criteriaView.mySwitch.addTarget(self, action: #selector(requirementSwitchPressed), for: .valueChanged)
            }
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
    
    @objc func requirementSwitchPressed(mySwitch: UISwitch) {
        if mySwitch.isOn {
            self.passedCount = self.passedCount + 1
        } else {
            self.passedCount = self.passedCount - 1
        }
    }
}

class ExamSectionHeader: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!

}

class MultipleChoiceView : UITableViewCell {
    
    var criteriaList:[String]!
    weak var header:UILabel!;
    var resultKey:String!
    
    func setup(headerName: String, criteriaList: [String]) {
        
        let header = UILabel();
        header.text = headerName;
        self.contentView.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(50)
            make.top.equalTo(self.contentView).offset(25)
        }
        
        let dividerView = UIView();
        self.contentView.addSubview(dividerView);
        dividerView.backgroundColor = UIColor.gray;
        dividerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.width.equalTo(1)
        }
        
        self.header = header;
        self.criteriaList = criteriaList;
        
        var count = 0;
        for criteria in self.criteriaList {
            let label = UILabel();
            label.text = criteria;
            self.contentView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.left.equalTo(self.header).offset(25)
                make.top.equalTo(self.header.snp.bottom).offset(10 + (count * 45))
            })
            
            let mySwitch = UISwitch()
            self.contentView.addSubview(mySwitch)
            mySwitch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.centerX).offset(30)
                make.centerY.equalTo(label)
                if (criteria == self.criteriaList.last) {
                    make.bottom.equalTo(self.contentView).offset(-20)
                }
            })
            
            count = count + 1;
        }
    }
}

class ExamCriteriaView: UITableViewCell {
    
    weak var nameLabel:UILabel!;
    weak var dividerView:UIView!;
    
    var resultKey:String!
    var textField:UITextField!
    var segment:UISegmentedControl!
    var mySwitch:UISwitch!
    
    func setup(type: String, key: String) {
        let nameLabel = UILabel()
        let dividerView = UIView()
        self.resultKey = key;
        self.contentView.addSubview(nameLabel);
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(75)
            make.centerY.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.contentView.addSubview(dividerView);
        dividerView.backgroundColor = UIColor.gray;
        dividerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.width.equalTo(1)
        }
        
        self.nameLabel = nameLabel;
        self.nameLabel.preferredMaxLayoutWidth = 250;
        self.nameLabel.numberOfLines = 0;
        self.dividerView = dividerView;
        
        switch type {
        case "CONTROL":
            self.segment = UISegmentedControl()
            self.addSubview(self.segment)
            self.segment.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView!.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-30)
                make.height.equalTo(30)
            });
            self.segment.addTarget(self, action: #selector(segmentTapped(segment:)), for: .valueChanged);
        case "INPUT":
            self.textField = UITextField()
            self.addSubview(self.textField)
            self.textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView!.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-30)
                make.height.equalTo(30)
            })
            self.textField.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
        case "SWITCH":
            self.mySwitch = UISwitch()
            self.addSubview(mySwitch)
            self.mySwitch.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dividerView!.snp.right).offset(30)
                make.centerY.equalTo(self)
                make.height.equalTo(30)
            })
            self.mySwitch.addTarget(self, action: #selector(switchChanged), for: .touchUpInside)
            let value = ExamResults.sharedInstance.getResult(key: self.resultKey);
            var boolValue:Bool;
            if value == "true" {
                boolValue = true
            } else {
                boolValue = false
            }
            self.mySwitch.isOn = boolValue
        default:break
        }
    }
    
    @objc func textChanged (textField: UITextField) {
        let value = textField.text;
        ExamResults.sharedInstance.addResult(key: self.resultKey, value: value!)
    }
    
    @objc func segmentTapped (segment: UISegmentedControl) {
        let value = segment.titleForSegment(at: segment.selectedSegmentIndex)
        ExamResults.sharedInstance.addResult(key: self.resultKey, value: value!)
    }
    
    @objc func switchChanged(_ resultSwitch: UISwitch) {
        var value:String!
        if resultSwitch.isOn {
            value = "true"
        } else {
            value = "false"
        }
        ExamResults.sharedInstance.addResult(key: self.resultKey, value: value);
    }
    
}
