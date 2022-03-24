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

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct EventsWidgetEntryView: View {
	internal init(entry: Provider.Entry) {
		self.entry = entry
		self.canAccessEvents = EventStore.shared.canAccessEvents
		self.events = EventStore.shared.events(for: entry.date)
	}
	
    var entry: Provider.Entry
	let canAccessEvents: Bool
	let events: [EKEvent]
	
    var body: some View {
		Group {
			if !canAccessEvents {
				Placeholder("No Access to Events")
			} else if events.isEmpty {
				Placeholder("No more jobs!")
			} else {
				VStack {
					LazyVGrid(columns: [GridItem()]) {
						ForEach(events, id: \.eventIdentifier) { event in
							HStack {
								Image(systemName: "star.fill")
									.foregroundColor(Color(cgColor: event.calendar.cgColor))
								
								VStack(alignment: .leading) {
									Text(event.title)
										.font(.title3.weight(.semibold))
									
									Text(event.startDate...event.endDate)
										.font(.subheadline.weight(.medium))
								}
								.padding(.vertical, 6)
								
								Spacer()
							}
							.padding(.horizontal, 10)
							.background(.ultraThinMaterial)
							.clipShape(ContainerRelativeShape())
						}
					}
					.padding()
					
					Spacer()
				}
			}
		}
		.background(.linearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
    }
}

@main
struct EventsWidget: Widget {
    let kind: String = "EventsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EventsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Today's Events")
        .description("Displays your events for today.")
    }
}

struct EventsWidget_Previews: PreviewProvider {
    static var previews: some View {
        EventsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
