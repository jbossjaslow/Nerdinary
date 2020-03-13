//
//  RegisterView.swift
//  Nerdinary
//
//  Created by Josh Jaslow on 3/12/20.
//  Copyright © 2020 Josh Jaslow. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
	
	@State var username = ""
	@State var password = ""
	
	@Binding var presented: Bool
	
    var body: some View {
		VStack(spacing: 20) {
			
			Text("Create a new Account")
				.font(.largeTitle)
				.foregroundColor(.white)
				.bold()
				.UseNiceShadow()
				.padding(.top)
			
			Spacer()
			
			InputTextField(title: "Username", text: $username)
			
			InputTextField(title: "Password", text: $password)
			
			Button(action: {
				self.presented = false
			}) {
				LoginButtonView(text: Text("Register"))
			}
			
			Spacer()
			
			Button(action: {
				self.presented = false
			}) {
				Text("Already have an account? Login here")
				.foregroundColor(.black)
			}
		}
		.padding([.leading, .trailing], 30)
		.background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
		.edgesIgnoringSafeArea(.all))
    }
}

struct RegisterView_Previews: PreviewProvider {
	
	@State static var presented: Bool = true
	
    static var previews: some View {
		RegisterView(presented: $presented)
    }
}