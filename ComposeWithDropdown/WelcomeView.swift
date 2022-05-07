//
//  WelcomeView.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import SwiftUI

struct WelcomeView: View {
	@State private var goToView = "WelcomeView"
	@EnvironmentObject var lessonToday: LessonToday
	
	var body: some View {
		if self.goToView == "WelcomeView" {
			VStack{
				Spacer()
				HStack{
					Spacer()
					Text("Hi Ege!")
						.font(.system(size: 60))
						.foregroundColor(Color.yellow)
						.padding()
					Spacer()
				}
				
				Button(action: {
					withAnimation{
						self.goToView = "QuestionView"
					}
				}) {
					Circle()
						.strokeBorder(Color.black, lineWidth: 1)
						.background(Circle().foregroundColor(Color.white.opacity(0.8)))
						.frame(width:70,height:70)
						.overlay(
							Image(systemName: "arrow.right")
								.resizable()
								.scaleEffect(0.6)
								.foregroundColor(Color.black)
						)
				}
				.buttonStyle(PlainButtonStyle())
				Text(lessonToday.subject)
					.font(.system(size: 40))
					.foregroundColor(Color.white)
					.padding()
				Spacer()
			}
			.background(
				Image(lessonToday.myTheme.contentPageBackground)
					.resizable()
			)
		}else{
			QuestionView().transition(.move(edge: .leading))
		}
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView().environmentObject(LessonToday())
	}
}

