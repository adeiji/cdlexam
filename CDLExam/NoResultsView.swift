//
//  NoResultsView.swift
//  CDLExam
//
//  Created by adeiji on 3/22/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

import UIKit

class NoResultsView : UIView {
    
    func setup(superview: UIView) {
        let label = UILabel()
        label.text = "No Results"
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(superview)
        }
    }
    
}
