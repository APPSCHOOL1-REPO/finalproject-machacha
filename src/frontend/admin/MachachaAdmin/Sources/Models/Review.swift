//
//  Review.swift
//  MachachaAdmin
//
//  Created by geonhyeong on 2023/02/14.
//

import Foundation

struct Review: Hashable, Identifiable {
	let id: String
	let reviewer: String            // 리뷰쓴 사람의 userID
	let foodCartId: String          // foodCart id
	let grade: Double               // 리뷰의 평점
	let description: String         // 사용자 후기
	let imageId: [String]           // 사용자가 review 올린 사진들
	let updatedAt: Date
	let createdAt: Date
	var gradeRounded: String {
		return String(format: "%.1f", grade)
	}
	
	static func getDummy1() -> Self {
		return Review(id: "tMa78vORR05hLmDXRojl", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "CE3AF1BA-E63C-4C9B-B96C-B289626152EA", grade: 2.3, description: "축구 보면서 머것어요. 완전 맛있어서 정신 못차리고 먹었더니 호떡이 사라지는 마법을 느꼈슴니다.", imageId: [], updatedAt: Date(), createdAt: Date())
	}
	static func getDummy2() -> Self {
		return Review(id: "tMa78vORR05hLmDXRojl", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "CE3AF1BA-E63C-4C9B-B96C-B289626152EA", grade: 2.3, description: "2", imageId: ["IMG_9432.HEIC"], updatedAt: Date(), createdAt: Date())
	}
	static func getDummy3() -> Self {
		return Review(id: "tMa78vORR05hLmDXRojl", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "CE3AF1BA-E63C-4C9B-B96C-B289626152EA", grade: 2.3, description: "3", imageId: ["IMG_9432.HEIC", "IMG_2468.HEIC"], updatedAt: Date(), createdAt: Date())
	}
	static func getListDummy() -> [Self] {
		return [
			Review(id: "qsPzae844YI3jljYVoaT", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "InzqNwgl15TytWNOdIZz", grade: 2.3, description: "11", imageId: [], updatedAt: Date(), createdAt: Date()),
			Review(id: "qsPzae844YI3jljYVoaT", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "InzqNwgl15TytWNOdIZz", grade: 2.3, description: "22", imageId: ["test.jpg"], updatedAt: Date(), createdAt: Date()),
			Review(id: "qsPzae844YI3jljYVoaT", reviewer: "egmqxtTT1Zani0UkJpUW", foodCartId: "InzqNwgl15TytWNOdIZz", grade: 2.3, description: "33", imageId: ["test.jpg", "test.jpg", "test.jpg"], updatedAt: Date(), createdAt: Date())]
	}
}
