//
//  MapViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = NMFNaverMapView(frame: view.frame)
        view.addSubview(mapView)
        
//NMFMapView에서 사용 가능한 메서드
//        mapView.setLayerGroup(NMF_LAYER_GROUP_BICYCLE, isEnabled: true)
        
//NMFNaverMapView에서 사용 가능한 속성
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        mapView.showCompass = true
        
        mapView.positionMode = .compass
        
        // 좌표 랜덤 생성
        // 마커 생성
        // 마커 터치 시 나오는 모달 창 만들기 (킥보드 정보, 대여하기 버튼)
    }

}
