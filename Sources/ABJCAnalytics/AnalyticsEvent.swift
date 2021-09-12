//
//  File.swift
//  File
//
//  Created by Noah Kamara on 10.09.21.
//

import Foundation
import AnyCodable

public protocol AnalyticsEvent {
    typealias AnalyticsData = AnyEncodable

    var name: String { get }
    var data: AnyEncodable { get }
}
