//
//  SoundManager.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/7.
//

import Foundation
import SwiftUI
import AVKit

class SoundManager {
	static let instance = SoundManager()
	var player: AVAudioPlayer?
	//var moviePlayer: AVPlayer?
	enum SoundOption: String{
		case correctAnswer = "Bright Right Answer 4"
		case wrongAnswer = "Cartoon Brass Fail"
		case finished = "Cartoon Big Win"
	}
	
	func playSound(sound:String){
		guard let url = Bundle.main.url(forResource: sound, withExtension: ".wav") else {
			return
		}
		
		do{
			player = try AVAudioPlayer(contentsOf: url)
			player?.play()
		}catch let error{
			print("error playing sound. \(error.localizedDescription)")
		}
	}
}
