//
//  MyTheme.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/7.
//

import Foundation
import SwiftUI

struct MyTheme{
	var themeName = "default"
	
	var correctAnswerAudio:String = "Bright Right Answer 4"
	var wrongAnswerAudio:String = "Cartoon Brass Fail"
	var finishedLessonAudio:String = "Cartoon Big Win"
	var chooseWord:String = "Chatroom Send"
	var duplicatedWord:String = "Button Ding"
	var contentPageBackground:String = "chalkboard05"
	/*
	var arrowButtonStroke:Color = Color.yellow
	var arrowButtonBackground:Color = .arrowButton
	var arrowButtonOpacity = 0.4
	var contentButtonStroke:Color = .replyButtonStroke
	var contentButtonBackground:Color = .replyButton
	var contentButtonOpacity = 0.6
	var textInputBackgroundOpacity = 0.3
	
	var firstPageTextColor:Color = Color.black
	var contentTextColor:Color = .replyButtonText
	
	var firstPageBackground:String = "tileable_bg61"
	var contentPageBackground:String = "old_paper_background2"
	
	var wrongAnswerBackground:String = "wrong_answer_background"
	*/
	
	init(setThemeName:String? = "default"){
		if setThemeName == "green"{
			/*firstPageBackground = "t2_welcome_bg"
			arrowButtonStroke = Color("t2_arrow_btn_stroke")
			arrowButtonBackground = Color("t2_arrow_btn_background")
			arrowButtonOpacity = 0.4*/
			
			contentPageBackground = "chalkboard02_green"
			/*contentTextColor = Color("t2_content_main_text")
			contentButtonBackground = Color("t2_content_btn_background")
			contentButtonStroke = Color("t2_content_btn_stroke")*/
		}
		if setThemeName == "black2" {
			contentPageBackground = "03_Chalkboard_BG"
		}
		
		if setThemeName == "paper-1" {
			contentPageBackground = "paper-1"
		}
		
		if setThemeName == "paper-1-dark" {
			contentPageBackground = "paper-1-dark"
		}
	}
	
}
