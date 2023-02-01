//
//  ProfileViewModel.swift
//  Machacha
//
//  Created by geonhyeong on 2023/01/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class ProfileViewModel: ObservableObject {
	//MARK: Property wrapper
	@Published var currentUser: User?
	@Published var reviewUser: [Review] = []
	@Published var showLogin = false			// 로그인 관리
	@Published var isFaceID: Bool = UserInfo.isFaceID {		// FaceID
		willSet { // 값이 변경되기 직전에 호출, newValue에는 새로 초기화하고자 하는 값이 들어감
			UserDefaults.standard.set(newValue, forKey: "isFaceID")
		}
	}
	@Published var isAlert: Bool = UserInfo.isAlert {			// 알림
		willSet {
			UserDefaults.standard.set(newValue, forKey: "isAlert")
		}
	}
	@Published var isDarkMode: Bool = UserInfo.isDarkMode {	// 다크모드
		willSet {
			UserDefaults.standard.set(newValue, forKey: "isDarkMode")
		}
	}
    @Published var reviewer: User = User(id: "", isFirstLogin: true, email: "", name: "", profileId: "", favoriteId: [], visitedId: [], updatedAt: Date(), createdAt: Date())
    @Published var imageDict: [String : UIImage] = [:]
	
	//MARK: Property
	private let database = Firestore.firestore()
    let storage = Storage.storage()

	init() { // 임시: 자동 로그인시 초기화 해줘야함
		UserDefaults.standard.set(false, forKey: "isFaceID")	// FaceID
		UserDefaults.standard.set(false, forKey: "isAlert")		// 알림
		UserDefaults.standard.set(false, forKey: "isDarkMode")	// 다크모드
	}
	
	//MARK: - Read
	// User Data Fetch
	func fetchUser() async throws -> User? {
		guard let userId = UserInfo.token else { return nil }
		var user: User // 비동기 통신으로 받아올 Property
		
		let userSnapshot = try await database.collection("User").document(userId).getDocument() // 첫번째 비동기 통신
		let docData = userSnapshot.data()!
		
		let id: String = docData["id"] as? String ?? ""
		let isFirstLogin: Bool = docData["isFirstLogin"] as? Bool ?? false
		let email: String = docData["email"] as? String ?? ""
		let name: String = docData["name"] as? String ?? ""
		let profileId: String = docData["profileId"] as? String ?? ""
		let favoriteId: [String] = docData["favoriteId"] as? [String] ?? []
		let visitedId: [String] = docData["visitedId"] as? [String] ?? []
		let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
		let createdAt: Timestamp = docData["createdAt"] as! Timestamp

		user = User(id: id, isFirstLogin: isFirstLogin, email: email, name: name, profileId: profileId, favoriteId: favoriteId, visitedId: visitedId, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue())

		return user
	}
	
	// Reivews Data Fetch
	func fetchReivews() async throws -> [Review] {
		guard let userId = UserInfo.token else { return [] }
		var reviews = [Review]() // 비동기 통신으로 받아올 Property
		
		let reviewSnapshot = try await database.collection("Review").whereField("reviewer", isEqualTo: userId).getDocuments() // 첫번째 비동기 통신
		
		for review in reviewSnapshot.documents {
			let docData = review.data()
			
			let id: String = docData["id"] as? String ?? ""
			let reviewer: String = docData["reviewer"] as? String ?? ""
			let foodCartId: String = docData["foodCartId"] as? String ?? ""
			let grade: Double = docData["grade"] as? Double ?? 0.0
			let description: String = docData["description"] as? String ?? ""
			let imageId: [String] = docData["imageId"] as? [String] ?? []
			let updatedAt: Timestamp = docData["updatedAt"] as! Timestamp
			let createdAt: Timestamp = docData["createdAt"] as! Timestamp

            reviews.append(Review(id: id, reviewer: reviewer, foodCartId: foodCartId, grade: grade, description: description, imageId: imageId, upadatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue()))
		}
		
		return reviews
	}
	
	// 로그아웃
	func logout() async throws {
		currentUser = nil
	}
    
    func fetchReviewer(userId: String) async {
        do {
            let querysnapshot = try await database.collection("User")
                .whereField("id", isEqualTo: userId)
                .getDocuments()

            for document in querysnapshot.documents {
                let data = document.data()

                let id: String = data["id"] as? String ?? ""
                let isFirstLogin: Bool = data["isFirstLogin"] as? Bool ?? false
                let email: String = data["email"] as? String ?? ""
                let name: String = data["name"] as? String ?? ""
                let profileId: String = data["profileId"] as? String ?? ""
                let favoriteId: [String] = data["favoriteId"] as? [String] ?? []
                let visitedId: [String] = data["visitedId"] as? [String] ?? []
                let updatedAt: Timestamp = data["updatedAt"] as! Timestamp
                let createdAt: Timestamp = data["createdAt"] as! Timestamp

                // fetch image set
                self.fetchImage(userId: id, imageName: profileId)
                print("profileId : \(profileId)")

                reviewer = User(id: id, isFirstLogin: isFirstLogin, email: email, name: name, profileId: profileId, favoriteId: favoriteId, visitedId: visitedId, updatedAt: updatedAt.dateValue(), createdAt: createdAt.dateValue())
            }
        } catch {
            print("fetchReviews error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 서버의 Storage에서 이미지를 가져오는 Method
    func fetchImage(userId: String, imageName: String) {
        print("userId = \(userId), imageName = \(imageName)")
        let ref = storage.reference().child("images/\(userId)/\(imageName)")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("review image error while downloading image\n\(error.localizedDescription)")
                return
            } else {
                let image = UIImage(data: data!)
                self.imageDict[imageName] = image
            }
        }
    }
}
