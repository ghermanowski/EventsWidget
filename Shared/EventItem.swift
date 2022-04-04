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
			Image(systemName: "star.fill")
			
			VStack(alignment: .leading) {
				Text(event.title)
					.font(.subheadline.weight(.medium))
				
				Text(event.startDate...event.endDate)
					.font(.footnote.weight(.semibold))
					.foregroundStyle(.secondary)
			}
			.padding(.vertical, 6)
			
			Spacer(minLength: .zero)
		}
		.foregroundColor(eventColour)
		.blendMode(colourScheme == .light ? .plusDarker : .plusLighter)
		.padding(.horizontal, 10)
		.background {
			eventColour.opacity(0.125)
				.blendMode(colourScheme == .light ? .normal : .hardLight)
		}
    }
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        EventItem(EKEvent())
    }
}
