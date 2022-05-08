//
//  LessonAppConfig.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/8.
//

import Foundation

struct LessonAppConfig: Codable{
	var title:String
	var subject: String
	var scope: String
	var dir: String
	var file: String
	var active: Bool
}
