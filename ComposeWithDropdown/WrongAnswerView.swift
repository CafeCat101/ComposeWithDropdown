//
//  WrongAnswerView.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import SwiftUI

struct WrongAnswerView: View {
	@Binding var isPresented:Bool
	@EnvironmentObject var lessonToday: LessonToday
	var getMakeSentence:[String] = []
	
	var body: some View {
		VStack{
			HStack{
				Spacer()
				
				Image("badge_wrong_answer")
				
				Spacer()
				
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
			}
			
			HStack{
				Spacer()
				
				VStack{
					Circle()
						.strokeBorder(Color.black, lineWidth: 1)
						.background(Circle().foregroundColor(Color.white.opacity(0.8)))
						.frame(width:70,height:70)
						.overlay(
							Image(systemName: "xmark.circle.fill")
								.resizable()
								.foregroundColor(Color.black)
						)
					
					Text("\(getMakeSentence.joined(separator: ""))")
						.font(.system(size:55))
						.foregroundColor(Color.yellow)
					
					Spacer()
				}
				.padding(15)
				.frame(minWidth:400, minHeight: 400)
				.background(
					RoundedRectangle(cornerRadius: 25, style: .continuous)
						.strokeBorder(Color.gray,lineWidth: 1)
						.background(
							RoundedRectangle(cornerRadius: 25, style: .continuous)
								.foregroundColor(Color.white.opacity(0.4)))
				)
				
				VStack{
					Circle()
						.strokeBorder(Color.black, lineWidth: 1)
						.background(Circle().foregroundColor(Color.white.opacity(0.8)))
						.frame(width:70,height:70)
						.overlay(
							Image(systemName: "checkmark.circle.fill")
								.resizable()
								.foregroundColor(Color("iconCorrectAnswerExample"))
						)
					
					Text("\(lessonToday.quiz[lessonToday.at].answer)")
						.font(.system(size:55))
						.foregroundColor(Color.black)
					
					Spacer()
				}
				.padding(10)
				.frame(minWidth:400, minHeight: 400)
				.background(
					RoundedRectangle(cornerRadius: 25, style: .continuous)
						.strokeBorder(Color.gray,lineWidth: 1)
						.background(
							RoundedRectangle(cornerRadius: 25, style: .continuous)
								.foregroundColor(Color.white.opacity(0.4)))
				)
				
				Spacer()
			}
		}
		.padding(20)
		.background(
			Image(lessonToday.myTheme.contentPageBackground)
				.resizable()
		)
		.onAppear(perform: {
			SoundManager.instance.playSound(sound: lessonToday.myTheme.wrongAnswerAudio)
		})
	}
}

struct WrongAnswerView_Previews: PreviewProvider {
	static var previews: some View {
		WrongAnswerView(isPresented: .constant(false)).environmentObject(LessonToday())
	}
}
