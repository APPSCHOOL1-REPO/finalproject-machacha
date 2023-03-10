//
//  ReverseGeocodingService.swift
//  Machacha
//
//  Created by MacBook on 2023/02/04.
//

//import Foundation
//import Alamofire
//
//func reverseget(coords : String) {
//       var alabel = ""
//       let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(coord)&sourcecrs=epsg:4326&output=json&orders=legalcode,admcode,roadaddr"
//       let header: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID" : "t1d90xy372","X-NCP-APIGW-API-KEY" : "1iHB4AscQ8qLpAlct1s4h098xjv22nuxSzf9IbPu" ]
//       var si : [Character] = []
//       var gu : [Character] = []
//       var dong : [Character] = []
//
//       AF.request(url, method: .get, headers: header)
//           .validate(statusCode: 200..<300)
//           .responseData { response in
//               switch response.result {
//               case .success(let res):
//                   let decoder = JSONDecoder()
//                   do {
//                       self.price.removeAll()
//                       self.rateOfChange.removeAll()
//                       self.rateCalDateDiff.removeAll()
//                       self.nameLists.removeAll()
//                       self.tableView1.reloadData()
//                       let data = try decoder.decode(ReverseModel.self, from: res)
//                       //self.model.append(contentsOf: data.results)
//                       si.append(contentsOf: data.results[0].region.area1.name)
//                       let siString = String(si)
//                       gu.append(contentsOf: data.results[0].region.area2.name)
//                       let guString = String(gu)
//                       dong.append(contentsOf: data.results[0].region.area3.name)
//                       let dongString = String(dong)
//                       alabel = siString + " " + guString + " " + dongString
//                       self.searchBar.searchTextField.text = alabel
//                       self.getEstateList(name: alabel)
//                       self.setLineChartView(Areaname : alabel)
//
//                   } catch {
//                       print("erorr in decode")
//                   }
//               case .failure(let err):
//                   print(err.localizedDescription)
//               }
//           }
//       }
//
//   let marker = NMFMarker()
//   var coord = ""
//   func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
//       coord = "\(latlng.lng)" + "," + "\(latlng.lat)"
//       reverseget(coords: coord)
//       marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
//       marker.isHideCollidedMarkers = true
//       marker.mapView = mapView
//
//   }

import Foundation
import Combine

enum ReverseGeocodeRouter {
    
    case get
    private enum HTTPMethod {
        case get
        
        var value: String {
            switch self {
            case .get: return "GET"
            }
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .get :
            return .get
        }
    }
    func asURLRequest(latitude: Double, longitude: Double) throws -> URLRequest {
        // requestAddress -> ?????? ????????? String ??? ????????? ?????????
        let queryURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(longitude),\(latitude)&sourcecrs=epsg:4326&orders=addr&output=json"
        let encodeQueryURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //NaverAPIEnum.naverApI.clientID
        var request = URLRequest(url: URL(string: encodeQueryURL)!)
        
        //????????? ????????? ?????????
        request.setValue("zvl4jgdvym", forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.setValue("yOxBP59CvSOVeyBM19ecoB8qTwdqCrkS5gi5dDVj", forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        request.httpMethod = method.value
        return request
    }
    
}


enum ReverseGeocodeService {
    
    static func getReverseGeocode(latitude: Double, longitude: Double) -> AnyPublisher<Welcome, Error> {
        // geocode ?????? url
        let queryURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(longitude),\(latitude)&sourcecrs=epsg:4326&orders=addr&output=json"
        
        //MARK: URL??? string:??? ??????, ????????? ?????? ????????? ?????? ????????????, ??????, ???????????? ?????? ???????????? ????????????.!!
        // ?????? ????????? ????????? ????????? ?????????
        let encodeQueryURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: encodeQueryURL)!)
        do {
            request = try ReverseGeocodeRouter.get.asURLRequest(latitude: latitude, longitude: longitude)
        } catch {
            print("http error")
        }
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map{ $0.data}
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

struct ReverseGeocodeDTO: Codable {
    let results: [Welcome]
}


final class NaverAPIViewModel: ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    
    @Published var reverseGeocodeResult = [Welcome]()
    @Published var address : String = "???????????????"
    @Published var region : String = "???????????????"
    
    init(){
        reverseGeocodeResult = []
    }
    var fetchGeocodeSuccess = PassthroughSubject<(), Never>()
    var insertGeocodeSuccess = PassthroughSubject<(), Never>()
    
    var fetchReverseGeocodeSuccess = PassthroughSubject<(), Never>()
    var insertReverseGeocodeSuccess = PassthroughSubject<(), Never>()
    
    
    func fetchReverseGeocode(latitude: Double, longitude: Double) {
        
        ReverseGeocodeService.getReverseGeocode(latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink { (completion: Subscribers.Completion<Error>) in
                //unowned??? ????????? ????????? ?????????????
            } receiveValue: { [unowned self] (data: Welcome) in
                reverseGeocodeResult = [data]
                region = "\(data.results[0].region.area1.name) \(data.results[0].region.area2.name) \(data.results[0].region.area3.name)"
                let number2 = data.results[0].land.number2
                if number2 == "" {
                    address = "\(region) \(data.results[0].land.number1)"
                }else{
                    address = "\(region) \(data.results[0].land.number1)-\(number2)"
                }
                fetchReverseGeocodeSuccess.send()
            }.store(in: &subscription)
        print("fetchReverseGeocode")
    }
}
