//
//  LoginView.swift
//  Nerdinary
//
//  Created by Josh Jaslow on 3/10/20.
//  Copyright © 2020 Josh Jaslow. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
	
	@EnvironmentObject var viewRouter: ViewRouter
	
	@State private var username = ""
	@State private var password = ""
	@State var presentingRegisterView: Bool = false
	
    var body: some View {
		VStack {
			
			Text("Nerdinary")
				.foregroundColor(.white)
				.font(.system(size: 48))
				.bold()
				.UseNiceShadow()
				.padding(.top)
			
			Spacer()
			
			VStack(spacing: 20) {
				
				InputTextField(title: "Username", text: $username)
				
				InputTextField(title: "Password", text: $password, secure: true)
				
				Spacer().frame(height: 40)
				
				Button(action: {
					UIApplication.shared.endEditing()
					self.login()
				}) {
					WideButtonView(text: "Login")
					.UseNiceShadow()
				}
			}
				.padding([.leading, .trailing], 30) //should refactor this for geometry reader at some point to make more modular
			
			Spacer()
			
			registerButton(presenting: $presentingRegisterView)
		}
		.background(LinearGradient(gradient: Gradient(colors: [Color("Color Scheme Purple"), Color("Color Scheme Blue")]), startPoint: .top, endPoint: .bottom)
		.edgesIgnoringSafeArea(.all))
		.ableToEndEditing()
		
    }
	
	func login() {
		self.viewRouter.currentPage = .main
	}
	
	func authenticate() {
		let context = LAContext()
		var error: NSError?

		// check whether biometric authentication is possible
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			// it's possible, so go ahead and use it
			let reason = "We need to unlock your data."

			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				// authentication has now completed
				DispatchQueue.main.async {
					if success {
						// authenticated successfully
						self.viewRouter.currentPage = .main
					} else {
						// there was a problem
					}
				}
			}
		} else {
			// no biometrics
		}
	}
}

struct InputTextField: View {
	
	var title: String
	@Binding var text: String
	var secure: Bool = false
	
	@ViewBuilder
	var body: some View {
		
		if secure {
			SecureField(title, text: $text)
			.modifier(NerdInput())
		} else {
			TextField(title, text: $text)
			.modifier(NerdInput())
		}
	}
	
	private struct NerdInput: ViewModifier {
		func body(content: Content) -> some View {
			content
				.padding()
				.background(Color("TextFieldColor"))
				.cornerRadius(20)
				.UseNiceShadow()
		}
	}
}

struct WideButtonView: View {
	
	var text: String = "Custom Text"
	var backgroundColor: Color = .green
	var cornerRadius: CGFloat = 15
	var systemFontSize: CGFloat = 24
	
	var body: some View {
		HStack {
			Spacer()

			Text(text)
			.foregroundColor(.white)
			.font(.system(size: self.systemFontSize))
			.padding([.top, .bottom], 5)

			Spacer()
		}
		.background(self.backgroundColor)
		.cornerRadius(self.cornerRadius)
	}
}

struct registerButton: View {
	
	@Binding var presenting: Bool
	
	var body: some View {
		VStack {
			Button(action: {
				self.presenting = true
			}) {
				Text("Don't have an account? Register here")
					.foregroundColor(.black)
			}
			.sheet(isPresented: $presenting) {
				RegisterView(presented: self.$presenting)
			}
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	
	@State static var isUnlocked: Bool = false
	
    static var previews: some View {
		LoginView().environmentObject(ViewRouter())
    }
}
