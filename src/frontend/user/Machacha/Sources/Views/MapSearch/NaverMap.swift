//
//  NaverMap.swift
//  Machacha
//
//  Created by Park Jungwoo on 2023/01/18.
//

import SwiftUI
import NMapsMap

struct NaverMap: UIViewRepresentable {
    @Binding var coord: (Double, Double)
    @Binding var currentIndex: Int
    var foodCarts: [FoodCart]
    var markers: [NMFMarker] = []
    @EnvironmentObject var mapSearchViewModel: MapSearchViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(coord)
    }
    
    init(coord: Binding<(Double, Double)>, currentIndex: Binding<Int>, foodCarts: [FoodCart]) {
        self._coord = coord
        self._currentIndex = currentIndex
        self.foodCarts = foodCarts
        for (index, foodCart) in foodCarts.enumerated() {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: foodCart.geoPoint.latitude, lng: foodCart.geoPoint.longitude)
            
            let image = NMFOverlayImage(image: UIImage(named: foodCart.markerImage) ?? UIImage())
            marker.iconImage = image
            
            marker.width = CGFloat(50)
            marker.height = CGFloat(50)
            marker.isHideCollidedMarkers = true
            
            
            self.markers.append(marker)
        }
    }
    
    
    
    // MARK: - Map을 그리고 생성하는 메서드
    func makeUIView(context: Context) -> some NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        //        view.showLocationButton = true
        for (index, marker) in markers.enumerated() {
            // MARK: - Mark 터치 시 이벤트 발생
            marker.touchHandler = { (overlay) -> Bool in
//                print("\(foodCart.name) marker touched")
                coord = (marker.position.lat, marker.position.lng)
                print("geoPoint : \(coord)")

                print("naverMap Index : \(currentIndex)")
                currentIndex = index
                return true
            }
        
            marker.mapView = view.mapView
        }
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        view.mapView.touchDelegate = context.coordinator
        print("markers : \(markers.count)")
        return view
    }
    
    // MARK: - Map이 업데이트 될 때 발생하는 메서드
    func updateUIView(_ uiView: UIViewType, context: Context) {
        

        var coord = NMGLatLng(lat: coord.0, lng: coord.1)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .easeIn
        cameraUpdate.animationDuration = 0.3
        uiView.mapView.moveCamera(cameraUpdate)
        
        print("currentindex : \(currentIndex)")
        // 이부분에서 Marker가 커지는 작업을 처리해줘야함 -> 마커 생성을 밖에서 해줘야할 거 같음
        for (index, marker) in markers.enumerated() {
            print("index\(markers[index])")
            markers[index].width = currentIndex == index ? CGFloat(70) : CGFloat(35)
            markers[index].height = currentIndex == index ? CGFloat(70) : CGFloat(35)
            marker.mapView = uiView.mapView

            marker.touchHandler = { (overlay) -> Bool in
//                print("\(foodCart.name) marker touched")
                self.coord = (marker.position.lat, marker.position.lng)
                print("geoPoint : \(coord)")

                print("naverMap Index : \(currentIndex)")
                currentIndex = index
                return true
            }
        }
    
        print("udateUIView")
    }
}

class Coordinator: NSObject {
    var coord: (Double, Double)
    init(_ coord: (Double, Double)) {
        self.coord = coord
    }
}

// MARK: - 카메라 이동시 발생하는 Delegate
extension Coordinator: NMFMapViewCameraDelegate {
    // 카메라의 움직임이 시작할 때 호출
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        //        print("카메라 변경 - reason: \(reason)")
    }
    
    // 카메라가 움직이고 있을 때 호출
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        
    }
    
    // 카메라의 움직임이 끝났을 때 호출
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        coord = (mapView.cameraPosition.target.lat, mapView.cameraPosition.target.lng)
//        print("현재 카메라 좌표 : \(coord)")
    }
}

// MARK: - 지도 터치에 이용되는 Delegate
extension Coordinator: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("Map Tapped")
    }
}
