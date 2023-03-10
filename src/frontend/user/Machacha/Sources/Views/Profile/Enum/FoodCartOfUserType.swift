//
//  FoodCartOfUserType.swift
//  Machacha
//
//  Created by geonhyeong on 2023/01/26.
//

import Foundation
import SwiftUI

enum FoodCartOfUserType: Hashable {
	case favorite				// 즐겨찾기
	case review					// 내가 쓴 리뷰
	case visited				// 가봤어요
	case register				// 등록한 포장마차

	// display text
	var display: String {
		switch self {
		case .favorite:
			return "즐겨찾기"
		case .review:
			return "리뷰관리"
		case .visited:
			return "가봤어요"
		case .register:
			return "등록한가게"
		}
	}
	
	// NavigationLink or Toggle
	var image: String {
		switch self {
		case .favorite:
			return "heart.fill"
		case .review:
			return "square.and.pencil"
		case .visited:
			return "checkmark.seal.fill"
		case .register:
			return "house.fill"
		}
	}
	
	// system 이미지 color
	var color: Color {
		switch self {
		case .favorite:
			return Color("Color3")
		case .review:
			return Color("Color6")
		case .visited:
			return Color("Color5")
		case .register:
			return Color("Color1")
		}
	}
	
	// Register에 plus.circle.fill를 badge
	var badge: String {
		switch self {
		case .register:
			return "plus.circle.fill"
		default:
			return ""
		}
	}
}
