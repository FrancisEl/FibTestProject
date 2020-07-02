//
//  FibObject.swift
//  FibTest App
//
//  Created by Francis Elias on 6/23/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import Foundation
import BigInt

struct FibObject {

    var number : BigInt?
    var startTime : Date?
    var endTime : Date?
    var time : Double?
    var numberString : String?

    init() { }
}

// MARK: FibObject inherited from Equatable in order to make our custom object to be used in XCUnitTest, and to choose which attributes are responsible for comparing 2 FibObjects

extension FibObject : Equatable {
    static func ==(lhs: FibObject, rhs: FibObject) -> Bool {
        return lhs.number == rhs.number
    }
}
