//
//  File.swift
//  File
//
//  Created by Noah Kamara on 11.09.21.
//

import AnyCodable
import Foundation

public class AnalyticsManager<Event: AnalyticsEvent> {
    private let engine: AnalyticsEngine
    private let appInfo: [String: AnyEncodable]

    public var id: UUID {
        let string = UserDefaults.standard.string(forKey: "analytics-id")
        guard let string = string, let uuid = UUID(uuidString: string) else {
            regenerateID()
            return self.id
        }
        return uuid
    }

    public func regenerateID() {
        UserDefaults.standard.set(UUID().uuidString, forKey: "analytics-id")
    }

    public init(engine: AnalyticsEngine, appInfo: [String: AnyEncodable]) {
        self.engine = engine
        self.appInfo = appInfo
    }

    public func send(_ event: Event, with metadata: [String: AnyEncodable] = [:]) {
        engine.send(.init(for: event, id, with: metadata, app: appInfo))
    }
}
