//
//  ContentView.swift
//  Shared
//
//  Created by Gregor Hermanowski on 24. March 2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		Button {
			EventStore.shared.requestAccess()
		} label: {
			Text("Request Access")
				.padding(8)
		}
		.buttonStyle(.borderedProminent)
		.tint(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
