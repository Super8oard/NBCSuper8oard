//
//  MapViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    lazy var mapView = NMFNaverMapView(frame: view.frame)
    var locationManager = CLLocationManager()
    lazy var boardList = [Board]()
    var numberOfDummyData = 30
    
    
    lazy var markerTapEvent = { [weak self] (overlay: NMFOverlay) -> Bool in
        let marker = overlay
        var tappedBoard: Board?
        for board in self!.boardList {
            if marker.userInfo["id"] as! String == String(board.boardNumber) {
                tappedBoard = board
            } else { continue }
        }
        let detailVC = DetailViewController(selectedBoard: tappedBoard)
        // 마커에 해당된 데이터 빼고 isrented 결과값 대신 넣기 -> 마커 지도에서 사라짐
        
        // boardList 동시성 이슈 체크(코드 병합 시) ThreadLock, Mutex, Semaphore
        detailVC.isRented = { [weak self] board in
            for i in 0..<self!.boardList.count {
                if self!.boardList[i].boardNumber == board.boardNumber {
                    self?.boardList[i].isAvailable = board.isAvailable
//                    marker.hidden = board.isAvailable ? "YES" : "NO"
                }
            }
        }
        self?.present(detailVC, animated: true, completion: nil)
        return true
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
        mapView.mapView.touchDelegate = self
        locationManager.delegate = self
        view.addSubview(mapView)
        setLocationData()
//NMFMapView에서 사용 가능한 메서드
//        mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: true)
        
//NMFNaverMapView에서 사용 가능한 속성
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        mapView.showCompass = true
        mapView.mapView.minZoomLevel = 5
        mapView.mapView.maxZoomLevel = 15
        makeDummyData()
// 마커 터치 시 나오는 모달 창 만들기 (킥보드 정보, 대여하기 버튼)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for board in boardList {
            placeBoardOnMap(board: board).mapView = self.mapView.mapView
        }
    }
}

//MARK: Marker Config Methods
extension MapViewController: NMFMapViewTouchDelegate {
    private func placeBoardOnMap(board: Board) -> NMFMarker {
        let marker = NMFMarker(position: board.boardLocation)
        marker.iconImage = NMFOverlayImage(image: UIImage(named: "BoardMarkerIcon")!.resized(to: CGSize(width: 25, height: 25)))
        marker.touchHandler = markerTapEvent
        marker.minZoom = 8
        marker.userInfo["id"] = String(board.boardNumber)
        return marker
    }
    
    private func generateRandomNMGLatLng() -> NMGLatLng {
        return NMGLatLng(lat: Double.random(in: 37.3200...37.3700), lng: Double.random(in: 127.0800...127.1300))
    }
}

//MARK: Location Config
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("현재 위치 권한 : \(manager.authorizationStatus)")
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            break
        case .restricted, .denied:
            break
        case .notDetermined:
            break
        default:
            break
        }
    }
    
    func setLocationData() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let latitude = locationManager.location?.coordinate.latitude ?? 0
        let longitude = locationManager.location?.coordinate.longitude ?? 0
        print(latitude, longitude)
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 7)
        mapView.mapView.moveCamera(cameraUpdate)
        cameraUpdate.animation = .easeIn
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
}
