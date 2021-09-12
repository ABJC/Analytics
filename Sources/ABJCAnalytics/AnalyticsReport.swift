//
//  File.swift
//  File
//
//  Created by Noah Kamara on 10.09.21.
//

import Foundation
import AnyCodable

public class AnalyticsReport: Encodable, CustomStringConvertible {
    public var description: String {
        return "AnalyticsReport(id='\(id)', timestamp='\(timestamp)', app='\(appInfo)', metadata='\(metadata)', event='\(eventName)', data='\(eventData)')"
    }
    
    public func log() throws {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print(json)
    }
    
    /// Installation ID
    public let id: UUID
    
    /// Timestamp of report
    public var timestamp: Int {
        let stamp = Date().timeIntervalSince1970
        return Int(floor(stamp))
    }
    
    /// Analytics Event Reference
    private let event: AnalyticsEvent
    
    /// Event Data
    public var eventData: AnyEncodable { event.data }
    
    /// Event Name
    public var eventName: String { event.name }
    
    /// Additional Metadata
    public let metadata: [String: AnyEncodable]
    
    /// App Info
    public let appInfo: [String: AnyEncodable]
    
    init(for event: AnalyticsEvent, _ id: UUID, with metadata: [String: AnyEncodable] = [:], app appInfo: [String: AnyEncodable]) {
        self.event = event
        self.id = id
        self.metadata = metadata
        self.appInfo = appInfo
    }
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, metadata
        case eventData = "data"
        case eventName = "event"
        case appInfo = "app"
    }
    
    public func encode(to encoder: Encoder) throws {
        var encoderContainer = encoder.container(keyedBy: CodingKeys.self)
        try encoderContainer.encode(id, forKey: .id)
        try encoderContainer.encode(appInfo, forKey: .appInfo)
        try encoderContainer.encode(timestamp, forKey: .timestamp)
        try encoderContainer.encode(eventName, forKey: .eventName)
        try encoderContainer.encode(eventData, forKey: .eventData)
        try encoderContainer.encode(metadata, forKey: .metadata)
    }
}
