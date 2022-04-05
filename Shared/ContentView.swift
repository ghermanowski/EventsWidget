//
//  ContentView.swift
//  Shared
//
//  Created by Gregor Hermanowski on 24. March 2022.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var eventStore: EventStore
	
    var body: some View {
		NavigationView {
			Group {
				if eventStore.canAccessEvents {
					VStack(alignment: .leading, spacing: 8) {
						ForEach(eventStore.events(for: .now), id: \.eventIdentifier) { event in
							EventItem(event)
								.cornerRadius(14)
						}
					}
					.padding(.horizontal)
					.toolbar {
						ToolbarItem(placement: .navigationBarTrailing) {
							Button("Add Event") {
								eventStore.addEvent()
							}
							.buttonStyle(.borderedProminent)
						}
					}
				} else {
					Button("Request Access") {
						Task {
							await eventStore.requestAccess()
						}
					}
					.buttonStyle(.borderedProminent)
				}
			}
			.navigationTitle("Events")
		}
		.navigationViewStyle(.stack)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
