//
//  EventsWidget.swift
//  EventsWidget
//
//  Created by Gregor Hermanowski on 24. March 2022.
//

import EventKit
import Intents
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {
	func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), configuration: ConfigurationIntent())
	}
	
	func getSnapshot(
		for configuration: ConfigurationIntent,
		in context: Context,
		completion: @escaping (SimpleEntry) -> ()
	) {
		let entry = SimpleEntry(date: Date(), configuration: configuration)
		completion(entry)
	}
	
	func getTimeline(
		for configuration: ConfigurationIntent,
		in context: Context,
		completion: @escaping (Timeline<Entry>) -> ()
	) {
		let entry = SimpleEntry(date: .now, configuration: configuration)
		let timeline = Timeline(entries: [entry], policy: .atEnd)
		completion(timeline)
	}
}

struct SimpleEntry: TimelineEntry {
	let date: Date
	let configuration: ConfigurationIntent
}

struct WidgetDate: View {
	var body: some View {
		VStack(alignment: .leading, spacing: -3) {
			Text(Date.now.formatted(.dateTime.weekday(.wide)).uppercased())
				.font(.caption2.weight(.semibold))
				.foregroundStyle(.red)
			
			Text(Date.now.formatted(.dateTime.day()))
				.font(.largeTitle.weight(.light))
		}
		.padding(.leading, 4)
		.offset(y: 2)
	}
}

struct EventsWidgetEntryView: View {
	internal init(entry: Provider.Entry) {
		self.entry = entry
		self.canAccessEvents = EventStore.shared.canAccessEvents
	}
	
	@Environment(\.widgetFamily) private var widgetFamily
	
	var entry: Provider.Entry
	let canAccessEvents: Bool
	
	var displayedEvents: [EKEvent] {
		var events = EventStore.shared.events(for: entry.date)
		
		if entry.configuration.showAllCalendars != 1,
		   let calendarIDs = entry.configuration.calendars?.compactMap(\.identifier) {
			events = events
				.filter { event in
					calendarIDs.contains { $0 == event.calendar.calendarIdentifier }
				}
		}
		
		// Ensures that the events fit the size of their widgets.
		switch widgetFamily {
			case .systemSmall, .systemMedium: return Array(events.prefix(2))
			case .systemLarge: return Array(events.prefix(6))
			default: return events
		}
	}
	
	var body: some View {
		if !canAccessEvents {
			Placeholder("No Access to Events")
		} else {
			let events = displayedEvents
			
			if events.isEmpty {
				Placeholder("No more jobs!")
			} else {
				VStack(alignment: .leading, spacing: .zero) {
					WidgetDate()
						.padding(.bottom, 8)
					
					VStack(spacing: 4) {
						ForEach(events, id: \.eventIdentifier) { event in
							EventItem(event)
						}
					}
					
					Spacer()
				}
			}
		}
	}
}

@main
struct EventsWidget: Widget {
	let kind: String = "EventsWidget"
	
	var body: some WidgetConfiguration {
		IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
			EventsWidgetEntryView(entry: entry)
				.containerBackground(.background, for: .widget)
		}
		.configurationDisplayName("Today's Events")
		.description("Your remaining events for today.")
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}

struct EventsWidget_Previews: PreviewProvider {
	static var previews: some View {
		EventsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
		
		EventsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
			.previewContext(WidgetPreviewContext(family: .systemMedium))
		
		EventsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
			.previewContext(WidgetPreviewContext(family: .systemLarge))
	}
}
