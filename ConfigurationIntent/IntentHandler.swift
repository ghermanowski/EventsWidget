//
//  IntentHandler.swift
//  ConfigurationIntent
//
//  Created by Gregor Hermanowski on 29. March 2022.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
	func provideCalendarsOptionsCollection(for intent: ConfigurationIntent) async throws -> INObjectCollection<EWCalendar> {
		INObjectCollection(items: calendars())
	}
	
	func defaultCalendars(for intent: ConfigurationIntent) -> [EWCalendar]? {
		calendars()
	}
	
	private func calendars() -> [EWCalendar] {
		EventStore.shared.calendars()
			.map { EWCalendar(identifier: $0.calendarIdentifier, display: $0.title) }
	}
	
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
}
