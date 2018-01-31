//
//  CDLExamTests.swift
//  CDLExamTests
//
//  Created by adeiji on 1/27/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import XCTest
@testable import CDLExam

class CDLExamTests: XCTestCase {
    var examVC:ExamViewController!
    struct Requirement {
        var type: String?
        var name: String?
        var values: [String]?;
    }
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        examVC = ExamViewController()
        examVC.viewDidLoad()
        XCTAssertNotNil(examVC.requirements);
        XCTAssertNotNil(examVC.examSections);
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        examVC = nil;
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetRequirementInfo () {
        var results = examVC.getRequirementInfo(requirement: "Test|CONTROL:TWO/THREE");
        var requirement = Requirement(type: "CONTROL", name: "Test", values: ["TWO", "THREE"])
        XCTAssertEqual(results.type, requirement.type)
        XCTAssertEqual(results.values!, requirement.values!)
        XCTAssertEqual(results.name, requirement.name)
        
        results = examVC.getRequirementInfo(requirement: "Test|INPUT:GVWR");
        requirement = Requirement(type: "INPUT", name: "Test", values: ["GVWR"])
        XCTAssertEqual(results.type, requirement.type)
        XCTAssertEqual(results.values!, requirement.values!)
        XCTAssertEqual(results.name, requirement.name)
        
        results = examVC.getRequirementInfo(requirement: "safety belt");
        requirement = Requirement(type: "SWITCH", name: "safety belt", values: nil)
        XCTAssertEqual(results.type, requirement.type)
        XCTAssertNil(results.values)
        XCTAssertEqual(results.name, requirement.name)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
