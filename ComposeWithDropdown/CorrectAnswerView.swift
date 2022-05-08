//
//  CorrectAnswerView.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import SwiftUI

struct CorrectAnswerView: View {
	@EnvironmentObject var lessonToday: LessonToday
	@Binding var isPresented:Bool
	
	var body: some View {
		VStack{
			Image("badge_correct_answer")
			/*
			Button(action: {
				withAnimation{
					isPresented = false
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
			 */
		}
		.padding(20)
		.frame(minWidth:400, minHeight:400)
		.background(
			Image(lessonToday.myTheme.contentPageBackground)
				.resizable()
				.scaledToFit()
		)
		.onAppear(perform: {
			SoundManager.instance.playSound(sound: lessonToday.myTheme.correctAnswerAudio)
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
				withAnimation{
					isPresented = false
				}
			}
		})
	}
}

struct CorrectAnswerView_Previews: PreviewProvider {
	static var previews: some View {
		CorrectAnswerView(isPresented: .constant(false)).environmentObject(LessonToday())
	}
}
