//
//  EventStore.swift
//  EventsWidget
//
//  Created by Gregor Hermanowski on 22. March 2022.
//

import EventKit
import Foundation

final class EventStore: ObservableObject {
	static let shared = EventStore()
	
	private init() {}
	
	let ekEventStore = EKEventStore()
	
	@Published private(set) var events = [EKEvent]()
	
	func refresh() {
		let today = Calendar.current.startOfDay(for: .now)
		let predicate = ekEventStore.predicateForEvents(withStart: today,
														end: today.advanced(by: 86400),
														calendars: nil)
		events = ekEventStore.events(matching: predicate)
	}
}
