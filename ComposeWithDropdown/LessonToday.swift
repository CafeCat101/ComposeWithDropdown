//
//  LessonToday.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/7.
//

import Foundation
import SwiftUI

class LessonToday: ObservableObject {
	@Published var subject:String = "Let's compose a sentence(demo)！"
	@Published var quiz: [Quiz] = [
		Quiz(asking: "What color is the grass?", answer: ["The grass"," is"," green."], options:[], picture:""),
		Quiz(asking: "What color is the cloud?", answer: ["The cloud"," is"," white."], options:[], picture:"")
	]
	@Published var optionShuffled = false
	@Published var language = "en"
	@Published var at = 0
	@Published var myTheme:MyTheme = MyTheme()
	@Published var userFolderPath = ""
	
	init() {
		loadLocalFile()
	}
	
	private func loadLocalFile() {
		do {
			let appConfigFile = URL(fileURLWithPath: FileManager.default.homeDirectoryForCurrentUser.path+"/Ege/macos_lesson/app_config.json").path
			if let jsonConfigData = try String(contentsOfFile: appConfigFile).data(using: .utf8) {
				
				let decodedConfigData = try JSONDecoder().decode([LessonAppConfig].self, from: jsonConfigData)
				
				for study in decodedConfigData {
					print("\(study.title)")
					print("\(study.active)")
					if study.active {
						do {
							userFolderPath = URL(fileURLWithPath: FileManager.default.homeDirectoryForCurrentUser.path+study.dir).path
							let lessonFile = userFolderPath+"/"+study.file
							if let jsonData = try String(contentsOfFile: lessonFile).data(using: .utf8) {
								let decodedData = try JSONDecoder().decode(Lesson.self, from: jsonData)
								subject = decodedData.subject
								quiz = decodedData.quiz
								optionShuffled = decodedData.optionshuffled
								language = decodedData.language
								
								myTheme = MyTheme(setThemeName: decodedData.theme)
							}
						} catch {
							print(error)
						}
						break;
					}
					
				}
				
				
			}else{
				print("failed to get content from app config")
			}
		} catch {
			print(error)
		}
		
		
	}
	
	
}
