//
//  MapViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, UIViewControllerTransitioningDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    weak var tabBarVC: TabBarController?
    lazy var boardList = [Board]()
    var numberOfDummyData = 30
    lazy var mapView = NMFMapView(frame: view.frame)
    var locationManager = CLLocationManager()
    
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        else { print("위치 서비스 off") }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude)")
            print("경도: \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    func makeDummyData() {
        for i in 0..<numberOfDummyData {
            let tempLoc = generateRandomNMGLatLng()
            let data = Board(boardType: "ninebot", boardNumber: i, boardBattery: 100, boardPrice: Int.random(in: 15...100), boardLocation: tempLoc, isAvailable: true)
            boardList.append(data)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.touchDelegate = self
        view.addSubview(mapView)
        
//NMFMapView에서 사용 가능한 메서드
        mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: true)
        
//NMFNaverMapView에서 사용 가능한 속성
//        mapView.showZoomControls = true
//        mapView.showLocationButton = true
//        mapView.showCompass = true
        makeDummyData()
// 마커 터치 시 나오는 모달 창 만들기 (킥보드 정보, 대여하기 버튼)
        
        tabBarVC = parent as? TabBarController
    }
    override func viewWillAppear(_ animated: Bool) {
        for board in boardList {
            placeBoardOnMap(board: board).mapView = self.mapView
        }
    }
    
//    func presentDetailView(input: Board?) {
//        let detailViewController = DetailViewController(selectedBoard: input)
//        detailViewController.modalPresentationStyle = .custom
//        detailViewController.transitioningDelegate = self
//        present(detailViewController, animated: true)
//    }
    
    lazy var markerTapEvent = { [weak self] (overlay: NMFOverlay) -> Bool in
        guard let marker = overlay as? NMFMarker else { return true }
        var tappedBoard: Board?
        for board in self!.boardList {
            if marker.tag == board.boardNumber {
                tappedBoard = board
            } else { return false }
        }
        let detailVC = DetailViewController(selectedBoard: tappedBoard)
        self?.present(detailVC, animated: true, completion: nil)
        return true
    }
    
//    private func mapView(_ mapView: NMFMapView, didTap marker: NMFMarker) -> Bool {
//            print("Marker tapped")
//            return true
//        }
    
}

//MARK: Marker Config Methods
extension MapViewController {
    private func placeBoardOnMap(board: Board) -> NMFMarker {
//        let markerTapEvent = { [weak self] (overlay: NMFOverlay) -> Bool in
//            guard let marker = overlay else { return true }
//            var tappedBoard: Board?
//            for board in self!.boardList {
//                if marker.position == board.boardLocation {
//                    tappedBoard = board
//                } else { return false }
//            }
//            let detailVC = DetailViewController(selectedBoard: tappedBoard)
//            self?.present(detailVC, animated: true, completion: nil)
//            return true
//        }
        let marker = NMFMarker(position: board.boardLocation)
        marker.iconImage = NMFOverlayImage(image: UIImage(named: "BoardMarkerIcon")!.resized(to: CGSize(width: 25, height: 25)))
        marker.touchHandler = markerTapEvent
        marker.maxZoom = 10
        marker.tag = UInt(board.boardNumber)
        return marker
    }

    private func generateRandomNMGLatLng() -> NMGLatLng {
        return NMGLatLng(lat: Double.random(in: 37.3200...37.3700), lng: Double.random(in: 127.0800...127.1300))
    }
    
//    func mapView(_ mapView: NMFMapView, didTap marker: NMFMarker) {
//        print(#function)
//        var tappedBoard: Board?
//        for board in self.boardList {
//            if marker.tag == board.boardNumber {
//                tappedBoard = board
//            } else { return }
//        }
//        let detailVC = DetailViewController(selectedBoard: tappedBoard)
//        present(detailVC, animated: true, completion: nil)
//    }
}

/*
let marker = NMFMarker()
let x = Double(item.xCoord) ?? 0.0
let y = Double(item.yCoord) ?? 0.0
                        
marker.captionRequestedWidth = 60             // 캡션 너비
marker.captionText = item.facName             // 캡션 네임
marker.position = NMGLatLng(lat: x, lng: y) // 마커 위치
marker.tag = UInt(i)                    // 마커 태그 (마커 식별용)
                        
let image = UIImage(named: IMAGE_NAME)!.resizeImage(targetSize: CGSize(width: 25, height: 25))
marker.iconImage = NMFOverlayImage(image: image) // 마커 이미지는 NMFOverlayImage를 사용하여 추가합니다.

// 마커 클릭 이벤트
let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
       // 이벤트 추가
       return true
}
                        
 marker.mapView = self.naverMapView.mapView
*/
