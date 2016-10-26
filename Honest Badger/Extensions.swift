//
//  NSDatePlusExtensions.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/27/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation
import UIKit

public func == (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSinceReferenceDate == rhs.timeIntervalSinceReferenceDate
}

public func < (lhs: Date, rhs: Date) -> Bool {
    return lhs.timeIntervalSinceReferenceDate < rhs.timeIntervalSinceReferenceDate
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
    return lhs.addingTimeInterval(rhs)
}

public func - (lhs: Date, rhs: TimeInterval) -> Date {
    return lhs.addingTimeInterval(-rhs)
}

public func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince(rhs)
}

extension UIColor {
    
    class func badgerBlue() -> UIColor {
        return UIColor(red: 18/255, green: 200/255, blue: 219/255, alpha: 1)
    }
}

extension Sequence {
    
    /**
     Returns a tuple with 2 arrays.
     The first array (the slice) contains the elements of self that match the predicate.
     The second array (the remainder) contains the elements of self that do not match the predicate.
     */
    func divide(_ predicate: (Self.Iterator.Element) -> Bool) -> (slice: [Self.Iterator.Element], remainder: [Self.Iterator.Element]) {
        var slice:     [Self.Iterator.Element] = []
        var remainder: [Self.Iterator.Element] = []
        forEach {
            switch predicate($0) {
            case true  : slice.append($0)
            case false : remainder.append($0)
            }
        }
        return (slice, remainder)
    }
}
