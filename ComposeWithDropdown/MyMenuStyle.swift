//
//  MyMenuStyle.swift
//  ComposeWithDropdown
//
//  Created by Leonore Yardimli on 2022/5/7.
//

import Foundation
import SwiftUI

struct MyMenuStyle: MenuStyle {
		func makeBody(configuration: Configuration) -> some View {
				Menu(configuration)
				.frame(width:100,height: 35,alignment:.center)
				.padding(10)
				.foregroundColor(Color.black)
				.background(
					RoundedRectangle(cornerRadius: 25, style: .continuous)
						.strokeBorder(Color.black,lineWidth: 1)
						.background(
							RoundedRectangle(cornerRadius: 25, style: .continuous)
								.foregroundColor(Color.white))
				)
		}
}
