//
//  ContentView.swift
//  Shared
//
//  Created by Gregor Hermanowski on 24. March 2022.
//

import SwiftUI

struct ContentView: View {
	@Environment(EventStore.self) private var eventStore
	
    var body: some View {
		NavigationStack {
			if eventStore.canAccessEvents {
				LazyVStack(alignment: .leading, spacing: 8) {
					ForEach(eventStore.todaysEvents, id: \.eventIdentifier) { event in
						EventItem(event)
					}
				}
				.padding()
				.containerShape(.rect(cornerRadius: 24))
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button("Add Event", action: eventStore.addEvent)
					}
				}
				.navigationTitle("Events")
			} else {
				ContentUnavailableView {
					Button("Request Access") {
						Task {
							await eventStore.requestAccess()
						}
					}
					.buttonStyle(.borderedProminent)
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
