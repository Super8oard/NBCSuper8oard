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
    
    let NAVER_CLIENT_ID = "rl9gufhvrz"
    let NAVER_CLIENT_SECRET = "RVdBT1JkkSZWCqIuxDqIFHrL0J7gNO6C7Hs7tEL9"
    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    
    lazy var mapView = NMFNaverMapView(frame: view.frame)
    var locationManager = CLLocationManager()
    lazy var boardList = [Board]()
    var numberOfDummyData = 30
    var user: User?
    var ridingBoardNumber: Int?
    
    lazy var inUseLabel: UILabel = {
        let label = UILabel()
        label.text = "이용 중"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.frame = CGRect(x: 150, y: 50, width: 100, height: 40)
        label.layer.cornerRadius = 20
        label.isHidden = true
        
        return label
    }()

    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setTitle("반납하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.frame = CGRect(x: 150, y: 700, width: 100, height: 40)
        button.isHidden = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(returnBoard), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let search = UIButton()
        search.setTitle("주소 검색", for: .normal)
        search.tintColor = .white
        search.backgroundColor = .systemBlue
        search.frame = CGRect(x: 200, y: 300, width: 100, height: 40)
        search.layer.cornerRadius = 10
        search.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return search
    }()
    
    @objc func returnBoard() {
        let returnAlert = UIAlertController(title: "반납하기", message: "반납하시겠습니까?", preferredStyle: .alert)
        let returnAction = UIAlertAction(title: "반납", style: .default) { _ in
            self.inUseLabel.isHidden = true
            self.user?.isRiding = false
            if let ridingBoardNumber = self.ridingBoardNumber {
                let currentLocation = self.setCurrentLocation()
                let marker = NMFMarker(position: currentLocation)
                marker.iconImage = NMFOverlayImage(image: UIImage(named: "BoardMarkerIcon")!.resized(to: CGSize(width: 25, height: 25)))
                marker.touchHandler = self.markerTapEvent
                marker.minZoom = 10
                marker.userInfo["id"] = String(ridingBoardNumber)
                marker.mapView = self.mapView.mapView
                self.returnButton.isHidden = true
                
                for i in 0..<self.boardList.count {
                    if self.boardList[i].boardNumber == ridingBoardNumber {
                        self.boardList[i].isAvailable = true
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        returnAlert.addAction(returnAction)
        returnAlert.addAction(cancelAction)
        present(returnAlert, animated: true)
    }
    
    @objc func searchButtonTapped() {
        let searchVC = SearchViewController()
        searchVC.setCameraLocation = { lat, lng in
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 7)
            self.mapView.mapView.moveCamera(cameraUpdate)
            cameraUpdate.animation = .easeIn
        }
        present(searchVC, animated: true)
    }
    // make dummy data for test
    func makeDummyData() {
        for i in 0..<numberOfDummyData {
            let tempLoc = generateRandomNMGLatLng()
            let data = Board(boardType: "ninebot", boardNumber: i, boardBattery: 100, boardPrice: Int.random(in: 150...180), boardLocation: tempLoc, isAvailable: true)
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
        mapView.mapView.minZoomLevel = 10
        mapView.mapView.maxZoomLevel = 15
        makeDummyData()
// 마커 터치 시 나오는 모달 창 만들기 (킥보드 정보, 대여하기 버튼)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for board in boardList {
            placeBoardOnMap(board: board).mapView = self.mapView.mapView
        }
        mapView.addSubview(inUseLabel)
        mapView.addSubview(returnButton)
        mapView.addSubview(searchButton)
    }
    
    //MARK: Marker Click Event
    lazy var markerTapEvent = { [weak self] (overlay: NMFOverlay) -> Bool in
        let marker = overlay
        var tappedBoard: Board?
        for board in self!.boardList {
            if marker.userInfo["id"] as! String == String(board.boardNumber) {
                tappedBoard = board
            } else { continue }
        }
        let detailVC = DetailViewController(selectedBoard: tappedBoard, user: self?.user)

        // boardList 동시성 이슈 체크(코드 병합 시) ThreadLock, Mutex, Semaphore
        detailVC.isRented = { [weak self] board in
            for i in 0..<self!.boardList.count {
                if self?.boardList[i].boardNumber == board.boardNumber {
                    self?.boardList[i].isAvailable = board.isAvailable
                }
            }
        }
        detailVC.hideMarker = { [weak self] isAvailable in
            marker.mapView = isAvailable ? self?.mapView.mapView : nil
            self?.user?.isRiding = !isAvailable
            self?.inUseLabel.isHidden = isAvailable
            self?.returnButton.isHidden = isAvailable
        }
        
        self?.ridingBoardNumber = tappedBoard?.boardNumber
        self?.present(detailVC, animated: true, completion: nil)
        return true
    }
    
}

//MARK: Marker Config Methods
extension MapViewController: NMFMapViewTouchDelegate {
    private func placeBoardOnMap(board: Board) -> NMFMarker {
        let marker = NMFMarker(position: board.boardLocation)
        marker.iconImage = NMFOverlayImage(image: UIImage(named: "BoardMarkerIcon")!.resized(to: CGSize(width: 25, height: 25)))
        marker.touchHandler = markerTapEvent
        marker.minZoom = 10
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
    
    func setCurrentLocation() -> NMGLatLng {
        let latlng = NMGLatLng()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        latlng.lat = locationManager.location?.coordinate.latitude ?? 0
        latlng.lng = locationManager.location?.coordinate.longitude ?? 0
        return latlng
    }
}
