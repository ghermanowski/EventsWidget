//
//  Placeholder.swift
//  EventsWidget
//
//  Created by Gregor Hermanowski on 24. March 2022.
//

import SwiftUI

struct Placeholder: View {
	internal init(_ title: String) {
		self.title = title
	}
	
	private let title: String
	
	var body: some View {
		VStack {
			Spacer()
			
			HStack {
				Spacer()
				
				Text(title)
					.font(.headline.weight(.medium))
					.foregroundColor(.secondary)
					.multilineTextAlignment(.center)
				
				Spacer()
			}
			.padding(.top)
			
			Spacer()
		}
		.overlay(alignment: .topLeading) {
			WidgetDate()
				.padding([.leading, .vertical], 12)
		}
	}
}
