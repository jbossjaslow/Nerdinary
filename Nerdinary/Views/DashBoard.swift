//
//  ContentView.swift
//  Nerdinary
//
//  Created by Josh Jaslow on 3/5/20.
//  Copyright © 2020 Josh Jaslow. All rights reserved.
//

import SwiftUI

struct DashBoard: View {
	
	@EnvironmentObject var viewRouter: ViewRouter
	
	@State var selectedView = 0
	
    var body: some View {
		TabView(selection: $selectedView) {
			LocalWordsView()
				.tabItem {
					Image(systemName: "1.circle")
					Text("Local")
				}.tag(0)
			
			Text("Global View")
			.tabItem {
				Image(systemName: "2.circle")
				Text("Global")
			}.tag(1)
			
			Text("Quiz View")
			.tabItem {
				Image(systemName: "3.circle")
				Text("Quiz")
			}.tag(2)
			
			SettingsView()
			.tabItem {
				Image(systemName: "4.circle")
				Text("Settings")
			}.tag(3)
		}
    }
}

struct SettingsView: View {
	
	@EnvironmentObject var viewRouter: ViewRouter
	
	var body: some View {
		Button(action: {
			self.viewRouter.currentPage = .login
		}) {
			Text("Logout")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		DashBoard().environmentObject(ViewRouter())
    }
}