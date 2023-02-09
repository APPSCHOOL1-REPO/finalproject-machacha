//
//  ApproveView.swift
//  MachachaAdmin
//
//  Created by geonhyeong on 2023/02/08.
//

import SwiftUI

struct ApproveView: View {
	//MARK: Property Wrapper
	@StateObject var approveVM = ApproveViewModel()
	
	var body: some View {
		List {
			ForEach(Array(approveVM.approveFoodCarts.enumerated()), id: \.offset) { index, foodCart in
				FoodCartCellView(approveVM: approveVM, index: index, foodCart: foodCart)
					.listRowBackground(Color.white.overlay(Rectangle().stroke(Color.black, lineWidth: 0.5)))
			} // ForEach
			.onDelete { indexSet in
				// TODO: delete items
				Task {
					indexSet.sorted(by: <).forEach { i in
						print(i.hashValue)
//						try await approveVM.removeFoodCart(approveVM.approveFoodCarts[index])
					}
					approveVM.approveFoodCarts.remove(atOffsets: indexSet)
				}
			}
		} // List
		.listStyle(.grouped)
		.onAppear {
			Task {
				approveVM.approveFoodCarts = await approveVM.fetchFoodCarts()
			} // Task
		}
		.refreshable {
			approveVM.approveFoodCarts = await approveVM.fetchFoodCarts()
		}
	}
}

// MARK: - FoodCart Cell View
struct FoodCartCellView: View {
	//MARK: Property Wrapper
	@ObservedObject var approveVM: ApproveViewModel
	@State private var image: UIImage?

	//MARK: Property
	let index: Int
	var foodCart: FoodCart
	
	var body: some View {
		NavigationLink {
			
		} label: {
			VStack(alignment: .leading) {
				HStack(spacing: 16) {
					VStack {
						Image(systemName: "square")
							.resizable()
							.frame(width: 22, height: 22)
							.overlay {
								Text("\(index + 1)")
									.font(.caption)
							}
					}
					
					VStack {
						if let image = image {
							Image(uiImage: image)
								.resizable()
								.clipShape(RoundedRectangle(cornerRadius: 8))
						} else {
							RoundedRectangle(cornerRadius: 8) // 임시
								.foregroundColor(.gray)
						}
					} // VStack
					.frame(width: 70, height: 70)
					
					VStack(alignment: .leading, spacing: 8) {
						Text(foodCart.name)
							.multilineTextAlignment(.leading)
							.lineLimit(2)
							.foregroundColor(Color(uiColor: .label))

						Text(foodCart.address) // 가게 주소
							.font(.caption)
							.foregroundColor(.secondary)
							.fixedSize(horizontal: true, vertical: false)
							.frame(maxWidth: .infinity, alignment: .leading)
							.lineLimit(2)
						
						HStack {
							HStack { // 평점
								Text("★ \(foodCart.gradeRounded)")
									.foregroundColor(.orange)
									.fixedSize(horizontal: true, vertical: false)
									.bold()
							} // HStack
							
							HStack(spacing: 15) { // 즐겨찾기
								Text("|")
								Image(systemName: "heart.fill")
									.frame(width: 3)
								Text("\(foodCart.favoriteCnt)")
									.fixedSize(horizontal: true, vertical: false)
							} // HStack
							
							HStack(spacing: 15) { // 가봤어요
								Text("|")
								Image(systemName: "checkmark.seal.fill")
									.frame(width: 3)
								Text("\(foodCart.visitedCnt)")
									.fixedSize(horizontal: true, vertical: false)
							} // HStack
							
							HStack(spacing: 13) { // 리뷰
								Text("|")
								Image(systemName: "square.and.pencil")
									.frame(width: 3)
								Text("\(foodCart.reviewId.count)")
									.fixedSize(horizontal: true, vertical: false)
							} // HStack
						} // HStack
						.font(.caption)
						.foregroundColor(Color(uiColor: UIColor.lightGray))
					} // VStack
				} // HStack
			} // VStack
		}
		.onAppear {
			Task {
				if let first = foodCart.imageId.first {
					image = await approveVM.fetchImage(foodCartId: foodCart.id, imageName: first)
				}
			}
		}
	}
}

// MARK: - FoodCart Detail View
struct FoodCartDetailView: View {
	//MARK: Property Wrapper
	@ObservedObject var approveVM: ApproveViewModel
	@State private var imageList: [UIImage]?

	//MARK: Property
	
	var body: some View {
		Text("")
	}
}

struct ApproveView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			ApproveView()
				.navigationTitle("가게 승인")
		}
    }
}
