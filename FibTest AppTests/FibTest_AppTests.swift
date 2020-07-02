//
//  FibTest_AppTests.swift
//  FibTest AppTests
//
//  Created by Francis Elias on 6/25/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import XCTest
@testable import FibTest_App

class FibTest_AppTests: XCTestCase {
    
    var mainViewController : MainViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }
    
    func testFibonacci() {
        var testFib = FibObject()
        testFib.number = 0
        var testFib2 = FibObject()
        testFib2.number = 1
        var testFib3 = FibObject()
        testFib3.number = 1
        let seqArray = [testFib, testFib2, testFib3]
        let seq = mainViewController.fibonaciSequence(2)
        XCTAssertEqual(seq, seqArray)
    }
    
    func testFibonacciZero() {
        let seq = mainViewController.fibonaciSequence(0)
        XCTAssertNotNil(seq)
    }
    
    func testFibonacciNegate() {
        let seq = mainViewController.fibonaciSequence(-1)
        XCTAssertNil(seq)
    }
}
