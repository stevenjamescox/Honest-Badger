//
//  NSDatePlusExtensions.swift
//  Honest Badger
//
//  Created by Steve Cox on 7/27/16.
//  Copyright © 2016 stevecoxio. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceReferenceDate == rhs.timeIntervalSinceReferenceDate
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceReferenceDate < rhs.timeIntervalSinceReferenceDate
}

public func + (lhs: NSDate, rhs: NSTimeInterval) -> NSDate {
    return lhs.dateByAddingTimeInterval(rhs)
}

public func - (lhs: NSDate, rhs: NSTimeInterval) -> NSDate {
    return lhs.dateByAddingTimeInterval(-rhs)
}

public func - (lhs: NSDate, rhs: NSDate) -> NSTimeInterval {
    return lhs.timeIntervalSinceDate(rhs)
}

extension SequenceType {
    
    /**
     Returns a tuple with 2 arrays.
     The first array (the slice) contains the elements of self that match the predicate.
     The second array (the remainder) contains the elements of self that do not match the predicate.
     */
    func divide(@noescape predicate: (Self.Generator.Element) -> Bool) -> (slice: [Self.Generator.Element], remainder: [Self.Generator.Element]) {
        var slice:     [Self.Generator.Element] = []
        var remainder: [Self.Generator.Element] = []
        forEach {
            switch predicate($0) {
            case true  : slice.append($0)
            case false : remainder.append($0)
            }
        }
        return (slice, remainder)
    }
}