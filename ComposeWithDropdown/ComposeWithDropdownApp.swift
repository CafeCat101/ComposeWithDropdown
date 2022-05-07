//
//  ComposeWithDropdownApp.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/7.
//

import SwiftUI

@main
struct ComposeWithDropdownApp: App {
	@StateObject var lessonToday = LessonToday()
	var body: some Scene {
		WindowGroup {
			WelcomeView().environmentObject(lessonToday)
		}
	}
}
