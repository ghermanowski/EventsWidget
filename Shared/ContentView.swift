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
		Group {
			if eventStore.canAccessEvents {
				Button(action: eventStore.addEvent) {
					Text("Add Event")
						.padding(8)
				}
			} else {
				Button(action: eventStore.requestAccess) {
					Text("Request Access")
						.padding(8)
				}
			}
		}
		.buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
