//
//  IntentHandler.swift
//  ConfigurationIntent
//
//  Created by Gregor Hermanowski on 29. March 2022.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
	/// Returns the calendars, which the user can choose the ones to exclude.
	/// - Parameter intent: Ignored.
	/// - Returns: A sectioned collection of `EWCalendar`s.
	func provideCalendarsOptionsCollection(for intent: ConfigurationIntent) async throws ->
	INObjectCollection<EWCalendar> {
		let calendars = EventStore.shared.calendars()
		
		// EventKit provides calendars of different 6 different types, each using an integer
		// as its raw value. Using these types, the calendars are grouped into sections.
		let sections: [INObjectSection<EWCalendar>] = (0...5).compactMap { typeValue in
			let ewCalendars = calendars.filter { $0.type.rawValue == typeValue }
				.map { EWCalendar(identifier: $0.calendarIdentifier, display: $0.title) }
			
			guard !ewCalendars.isEmpty else { return nil }
			return INObjectSection(title: "Category \(typeValue + 1)",
								   items: ewCalendars)
		}
		
		return INObjectCollection(sections: sections)
	}
	
	/// Returns the default selection of calendars.
	/// - Parameter intent: Ignored.
	/// - Returns: All available calendars.
	func defaultCalendars(for intent: ConfigurationIntent) -> [EWCalendar]? {
		EventStore.shared.calendars()
			.map { EWCalendar(identifier: $0.calendarIdentifier, display: $0.title) }
	}
}
