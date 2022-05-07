//
//  FinishedView.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import SwiftUI

struct FinishedView: View {
	@EnvironmentObject var lessonToday: LessonToday
	
	var body: some View {
		VStack{
			Spacer()
			
			HStack{
				Spacer()
				
				Image("badge_finished")
				
				Spacer()
			}
			
			Text("做完了！")
				.font(.system(size: 70))
				.fontWeight(.bold)
				.foregroundColor(Color.orange)
			
			Spacer()
		}
		.padding(10)
		.background(
			Image(lessonToday.myTheme.contentPageBackground)
				.resizable()
		)
		.onAppear(perform: {
			SoundManager.instance.playSound(sound: lessonToday.myTheme.finishedLessonAudio)
		})
	}
}

struct FinishedView_Previews: PreviewProvider {
	static var previews: some View {
		FinishedView().environmentObject(LessonToday())
	}
}
