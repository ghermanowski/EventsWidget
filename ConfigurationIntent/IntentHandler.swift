//
//  IntentHandler.swift
//  ConfigurationIntent
//
//  Created by Gregor Hermanowski on 29. March 2022.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
	func provideCalendarsOptionsCollection(for intent: ConfigurationIntent) async throws ->
	INObjectCollection<EWCalendar> {
		let calendars = EventStore.shared.calendars()
		
		let sections: [INObjectSection<EWCalendar>] = (0...5).compactMap { typeValue in
			let ewCalendars = calendars.filter { $0.type.rawValue == typeValue }
				.map { EWCalendar(identifier: $0.calendarIdentifier, display: $0.title) }
			
			guard !ewCalendars.isEmpty else { return nil }
			return INObjectSection(title: "Category \(typeValue + 1)",
								   items: ewCalendars)
		}
		
		return INObjectCollection(sections: sections)
	}
	
	func defaultCalendars(for intent: ConfigurationIntent) -> [EWCalendar]? {
		EventStore.shared.calendars()
			.map { EWCalendar(identifier: $0.calendarIdentifier, display: $0.title) }
	}
}
