//
//  QuestionView.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import SwiftUI
import AVFoundation

struct QuestionView: View {
	@State private var goToView = "QuestionView"
	@State private var answer:String = ""
	@EnvironmentObject var lessonToday: LessonToday
	@State private var makeSentence:[String] = []
	@State private var animateSentence = false
	@State private var rememberWord = ""
	@State private var showAnswerBtn = false
	@State private var showAnswer = false
	@State private var testSentence = ["Pingu"," and"," Robby"," like to"," go"," skiing.","Pingu"," and"," Robby"," like to"," go"," skiing."]
	@State private var getOptions:[String] = []
	
	var body: some View {
		if goToView == "QuestionView"{
			VStack{
				//Spacer()
				
				if let image = NSImage(contentsOf: URL(fileURLWithPath: lessonToday.userFolderPath+"/"+lessonToday.quiz[lessonToday.at].picture)) {
					Image(nsImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.shadow(color:.black, radius: 3, x:1, y: 1)
						.border(Color.white, width: 5)
						.frame(width:500, height:500)
				}
				Spacer().frame(height:20)
				
				HStack{
					Spacer()
					
					
					VStack{
						HStack{
							Text(lessonToday.quiz[lessonToday.at].asking)
								.font(.system(size:50))
								.foregroundColor(Color.white)
							Spacer()
						}
						
						Spacer().frame(height:20)
						
						HStack{
							Text("\(makeSentence.joined(separator: ""))")
								.font(.system(size:55))
								.foregroundColor(Color.yellow)
							
							if animateSentence==true{
								Text(rememberWord)
									.font(.system(size:55))
									.foregroundColor(Color.white)
									.transition(.offset(x: 0, y: 50))
									.onAppear(perform: {
										DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
											makeSentence.append(rememberWord)
											animateSentence = false
											isSentenceFinished()
										}
									})
							}
							
							if showAnswerBtn == false {
								Menu {
									ForEach(0..<getOptions.count) { index in
										Button(action:{
											self.pickAWord(selectedAnswer: getOptions[index])
										}){
											Text(getOptions[index])
												.font(.system(size: 40))
										}
									}
								} label: {
									Text("...")
										.font(.largeTitle)
										.foregroundColor(Color.black)
								}.menuStyle(MyMenuStyle())
							}
							
							
							Spacer()
							Button(action: {
								if makeSentence.count>0 {
									makeSentence.removeLast()
									isSentenceFinished()
								}
							}) {
								RoundedRectangle(cornerRadius: 22, style: .continuous)
									.strokeBorder(Color.white,lineWidth: 1)
									.background(
										RoundedRectangle(cornerRadius: 22, style: .continuous)
											.foregroundColor(Color.black.opacity(0.3)))
									.frame(width:60,height:60)
									.overlay(
										Image(systemName: "delete.left")
											.foregroundColor(Color.white)
									)
							}.buttonStyle(PlainButtonStyle())
							
							//if showAnswerBtn==true {
							Button(action: {
								if (makeSentence.joined(separator: "")==lessonToday.quiz[lessonToday.at].answer.joined(separator: "")) && lessonToday.at==lessonToday.quiz.count-1 {
									goToView = "FinishedView"
								}else{
									showAnswer = true
								}
							}) {
								RoundedRectangle(cornerRadius: 22, style: .continuous)
									.strokeBorder(Color.white,lineWidth: 1)
									.background(
										RoundedRectangle(cornerRadius: 22, style: .continuous)
											.foregroundColor(Color.black.opacity(0.3)))
									.frame(width:180,height:60)
									.overlay(
										Text("回答")
											.font(.system(size: 30))
											.fontWeight(.semibold)
											.foregroundColor(Color.white)
									)
							}
							.buttonStyle(PlainButtonStyle())
							.transition(.offset(x: 0, y: -50))
							//}
						}
						.padding(20)
						.background(
							RoundedRectangle(cornerRadius: 25, style: .continuous)
								.strokeBorder(Color.white,lineWidth: 1)
						)
					}
				}
				
				
				Spacer()
			}
			.onAppear {
				setQuizOptons()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					speak(textToSpeak: lessonToday.quiz[lessonToday.at].answer.joined(separator: ""))
				}
			}
			.padding(10)
			.background(
				Image(lessonToday.myTheme.contentPageBackground)
					.resizable()
			)
			.sheet(isPresented: $showAnswer){
				if makeSentence.joined(separator: "")==lessonToday.quiz[lessonToday.at].answer.joined(separator: "") {
					CorrectAnswerView(isPresented: $showAnswer)
						.onDisappear(perform: {
							lessonToday.at = lessonToday.at + 1
							resetQuestionValue()
							
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
								speak(textToSpeak: lessonToday.quiz[lessonToday.at].answer.joined(separator: ""))
							}
						})
				}else{
					WrongAnswerView(isPresented:$showAnswer, getMakeSentence: makeSentence)
						.onDisappear(perform: {
							lessonToday.quiz.append(lessonToday.quiz[lessonToday.at])
							lessonToday.at = lessonToday.at + 1
							resetQuestionValue()
							
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
								speak(textToSpeak: lessonToday.quiz[lessonToday.at].answer.joined(separator: ""))
							}
						})
				}
				
			}
		}else{
			if goToView=="FinishedView" {
				FinishedView()
			}
		}
	}
	
	private func speak(textToSpeak:String) {
		//print(AVSpeechSynthesisVoice.speechVoices())
		let utterance = AVSpeechUtterance(string: textToSpeak)
		if lessonToday.language == "ch" {
			utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
			//:sometime the identifier string is changed. just print the speechVoice list again
			utterance.rate = 0.3
		} else {
			utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
			//utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.samantha.premium")
			//:sometime the identifier string is changed. just print the speechVoice list again
			utterance.rate = 0.3
		}
		

		let synthesizer = AVSpeechSynthesizer()
		synthesizer.speak(utterance)
	}
	
	private func pickAWord(selectedAnswer:String){
		let chooseWord = selectedAnswer//lessonToday.quiz[lessonToday.at].options[selectedAnswer[0]][selectedAnswer[1]]
		//if makeSentence.contains(chooseWord){
		//word exists. play ding sound
		//	SoundManager.instance.playSound(sound: lessonToday.myTheme.duplicatedWord)
		//}else{
		//makeSentence.append(chooseWord)
		rememberWord = chooseWord
		print(chooseWord)
		print(makeSentence.count)
		SoundManager.instance.playSound(sound: lessonToday.myTheme.chooseWord)
		withAnimation{
			animateSentence = true
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			speak(textToSpeak: chooseWord)
		}
		//}
	}
	
	private func isSentenceFinished(){
		if makeSentence.count == lessonToday.quiz[lessonToday.at].answer.count {
			withAnimation{
				showAnswerBtn = true
			}
		}else{
			withAnimation{
				showAnswerBtn = false
			}
		}
	}
	
	private func resetQuestionValue(){
		makeSentence = []
		showAnswerBtn = false
		setQuizOptons()
	}
	
	private func setQuizOptons(){
		if lessonToday.optionShuffled {
			getOptions = lessonToday.quiz[lessonToday.at].options.shuffled()
		} else {
			getOptions = lessonToday.quiz[lessonToday.at].options
		}
	}
	
}

struct QuestionView_Previews: PreviewProvider {
	static var previews: some View {
		QuestionView().environmentObject(LessonToday())
	}
}
