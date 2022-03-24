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
	
	private(set) var canAccessEvents = EKEventStore.authorizationStatus(for: .event) == .authorized
	
	let ekEventStore = EKEventStore()
	
	func events(for date: Date) -> [EKEvent] {
		let startOfDay = Calendar.current.startOfDay(for: date)
		let predicate = ekEventStore.predicateForEvents(withStart: startOfDay,
														end: startOfDay.advanced(by: 86400),
														calendars: nil)
		return ekEventStore.events(matching: predicate)
	}
	
	func requestAccess() {
		ekEventStore.requestAccess(to: .event) { granted, error in
			guard error == nil else {
				print(error!)
				return
			}
			
			self.canAccessEvents = granted
		}
	}
}
