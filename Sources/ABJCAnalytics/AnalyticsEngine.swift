//
//  File.swift
//  File
//
//  Created by Noah Kamara on 11.09.21.
//

import AnyCodable
import Foundation

public protocol AnalyticsEngine: AnyObject {
    func send(_ report: AnalyticsReport)
}
