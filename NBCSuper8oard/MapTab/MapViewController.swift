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
    
    //더미데이터 생성
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
        
        tabBarVC = parent as? TabBarController
    }
    override func viewWillAppear(_ animated: Bool) {
        for board in boardList {
            placeBoardOnMap(board: board).mapView = self.mapView
        }
    }
    
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
    
}

//MARK: Marker Config Methods
extension MapViewController {
    private func placeBoardOnMap(board: Board) -> NMFMarker {
        
        let markerTapEvent = { [weak self] (overlay: NMFOverlay) -> Bool in
            guard let marker = overlay as? NMFMarker else { return true }
            var tappedBoard: Board?
            for board in self!.boardList {
                if marker.position == board.boardLocation {
                    tappedBoard = board
                } else { return false }
            }
            let detailVC = DetailViewController(selectedBoard: tappedBoard)
            self?.present(detailVC, animated: true, completion: nil)
            return true
        }

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
    
}
