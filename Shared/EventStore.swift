//
//  EventStore.swift
//  EventsWidget
//
//  Created by Gregor Hermanowski on 22. March 2022.
//

import Combine
import EventKit
import Foundation
import WidgetKit

final class EventStore: ObservableObject {
	static let shared = EventStore()
	
	private init() {
		NotificationCenter.default.publisher(for: .EKEventStoreChanged)
			.sink { notification in
				guard let info = notification.userInfo else { return }

				print("info", info)

				for (key, value) in info {
					guard let keyString = key as? String,
						  let intValue = value as? Int else { return }

					if intValue == 1 && keyString == "EKEventStoreCalendarDataChangedUserInfoKey" {
						WidgetCenter.shared.reloadAllTimelines()
					}
				}

			}
			.store(in: &cancellables)
	}

	private var cancellables = Set<AnyCancellable>()
	
	private(set) var canAccessEvents = EKEventStore.authorizationStatus(for: .event) == .authorized
	
	private var ekEventStore = EKEventStore()
	
	func events(for date: Date) -> [EKEvent] {
		let startOfDay = Calendar.current.startOfDay(for: date)
		let predicate = ekEventStore.predicateForEvents(withStart: startOfDay,
														end: startOfDay.advanced(by: 86400),
														calendars: nil)
		return ekEventStore.events(matching: predicate)
			.filter { $0.endDate > .now }
	}
	
	func addEvent() {
		let event = EKEvent(eventStore: ekEventStore)
		event.title = "Event"
		event.startDate = .now
		event.endDate = .now.advanced(by: 3600)
		event.calendar = ekEventStore.defaultCalendarForNewEvents
		
		do {
			try ekEventStore.save(event, span: .thisEvent)
			try ekEventStore.commit()
		} catch {
			print(error)
		}
	}
	
	func requestAccess() {
		ekEventStore.requestAccess(to: .event) { granted, error in
			guard error == nil else {
				print(error!)
				return
			}
			
			self.canAccessEvents = granted
			self.ekEventStore = EKEventStore()
		}
	}
}
