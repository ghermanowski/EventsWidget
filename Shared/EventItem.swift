//
//  EventItem.swift
//  EventsWidget
//
//  Created by Gregor Hermanowski on 29. March 2022.
//

import EventKit
import SwiftUI

struct EventItem: View {
	internal init(_ event: EKEvent) {
		self.event = event
	}
	
	@Environment(\.colorScheme) private var colourScheme
	
	private let event: EKEvent
	
    var body: some View {
		let eventColour = Color(cgColor: event.calendar.cgColor)
		
		HStack {
			VStack(alignment: .leading) {
				Text(event.title)
					.font(.footnote.weight(.semibold))
				
				if !event.isAllDay {
					Text(event.startDate...event.endDate)
						.font(.caption)
				}
			}
			.padding(.horizontal, 4)
			.padding(.vertical, 2)
			
			Spacer(minLength: .zero)
		}
		.foregroundStyle(eventColour)
		.blendMode(colourScheme == .light ? .plusDarker : .plusLighter)
		.background(eventColour.opacity(0.125), in: .containerRelative)
		.padding(.leading, 7)
		.overlay(alignment: .leading) {
			HStack(spacing: 3) {
				eventColour
					.frame(maxWidth: 4)
					.clipShape(.capsule)
				
				Spacer()
			}
		}
	}
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        EventItem(EKEvent())
    }
}
