//
//  BoardRegisterViewController.swift
//  NBCSuper8oard
//
//  Created by 석진 on 1/16/24.
//

import UIKit
import NMapsMap
import CoreLocation


class BoardRegisterViewController: UIViewController, UITextFieldDelegate, NMFMapViewDelegate, CLLocationManagerDelegate
{
    var board: [Board] = []
    var index: Int = 0
    
    var boardType: String = ""
    var boardNumber: Int = 0
    var boardBattery: Int = 0
    var boardPrice: Int = 0
    var boardLocation: NMGLatLng = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
    
    let pickerList: [String] = ["A", "B", "C"]
    
    var boardTypeTextField: UITextField!
    var boardTypePickerView: UIPickerView!
    var boardNumberTextField: UITextField!
    var boardBatteryTextField: UITextField!
    var boardPriceTextField: UITextField!
    var registerButton: UIButton!
    
    var locationManager = CLLocationManager()
    var locationOverlay: NMFLocationOverlay?
    
    // 맵 뷰 생성
    lazy var locationMapView: NMFMapView =
    {
        var mapView = NMFMapView()
        mapView = NMFMapView(frame: CGRect(x: 131, y: 490, width: 235, height: 200))
        mapView.logoInteractionEnabled = false // 로고 터치 불가능
        mapView.allowsZooming = true
        mapView.allowsScrolling = true
        self.locationOverlay = mapView.locationOverlay
        
        return mapView
    }()
    
    // 위치 정보 설정
    func setLocationData()
    {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let latitude = locationManager.location?.coordinate.latitude ?? 0
        let longitude = locationManager.location?.coordinate.longitude ?? 0
        boardLocation = NMGLatLng(lat: latitude, lng: longitude)
        print(boardLocation)
        
        let camereUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 14)
        locationMapView.moveCamera(camereUpdate)
        camereUpdate.animation = .easeIn
        
        guard let locationOverlay = locationOverlay   else { return }
        locationOverlay.hidden = false
        locationOverlay.location = NMGLatLng(lat: latitude, lng: longitude)
        locationOverlay.icon = NMFOverlayImage(name: "marker_icon")
    }
    
    
    // 레이블 생성 메서드
    func createLabel(text: String, top: CGFloat, left: CGFloat) -> UILabel
    {
        let label = UILabel()
        
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false     // AutoLayout
        
        NSLayoutConstraint.activate([
                // 위쪽 Constraints (Top)
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top),
                // 왼쪽 Constraints (Leading)
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: left),
        ])
        
        return label
    }
    
    // TextField 생성 메서드
    func createTextField(placeholder: String, top: CGFloat, left: CGFloat) -> UITextField
    {
        let textField = UITextField()
        
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        textField.delegate = self
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 235).isActive = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: left),
        ])
        
        return textField
    }
    
    // 키보드 입력 시작
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    // 키보드 Return 버튼이 눌렸을때
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    // TextField 입력 값 각 변수에 저장 ( 필요한 경우에는 형 변환 )
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField == boardTypeTextField
        {
            if let text = textField.text
            {
                self.boardType = text
            }
        }
        
        else if textField == boardNumberTextField
        {
            if let text = textField.text, let unwrapBoardNumber = Int(text)
            {
                self.boardNumber = unwrapBoardNumber
            }
        }
        
        else if textField == boardBatteryTextField
        {
            if let text = textField.text, let unwrapBoardNumber = Int(text)
            {
                self.boardBattery = unwrapBoardNumber
            }
        }
        
        else if textField == boardPriceTextField
        {
            if let text = textField.text, let unwrapBoardNumber = Int(text)
            {
                self.boardPrice = unwrapBoardNumber
            }
        }
    }
    
    // Toolbar 및 완료 버튼 생성
    func creatToolbarExitButton(textFieldName: UITextField)
    {
        let toolbar = UIToolbar()
        let exitButton = UIBarButtonItem()
        
        exitButton.title = "완료"
        exitButton.target = self
        exitButton.action = #selector(pickerExit)
        
        toolbar.tintColor = .blue
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.setItems([exitButton], animated: true)
        
        textFieldName.inputAccessoryView = toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, exitButton], animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setLocationData()
        
        // Label 목록
        let title = createLabel(text: "킥보드 등록", top: 77, left: 0)
            title.font = UIFont.systemFont(ofSize: 32)
            NSLayoutConstraint.activate([title.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        _ = createLabel(text: "기종", top: 160, left: 46)     // 기종 텍스트 레이블
        boardTypeTextField = createTextField(placeholder: "기종을 선택해주세요.", top: 154, left: 131)
        
        let boardTypePickerView = UIPickerView()        // PickerView 생성
        boardTypePickerView.delegate = self
        boardTypeTextField?.inputView = boardTypePickerView     //
        creatToolbarExitButton(textFieldName: boardTypeTextField)
        
        // 킥보드 번호 텍스트 레이블
        let boardNumberLabel = createLabel(text: "킥보드 번호\n(숫자 6자리)", top: 237, left: 19)
            boardNumberLabel.numberOfLines = 2
        boardNumberTextField = createTextField(placeholder: "킥보드 일련번호를 입력하세요.", top: 243, left: 131)
        boardNumberTextField.keyboardType = .numberPad
        creatToolbarExitButton(textFieldName: boardNumberTextField)
        
        
        // 배터리 용량 텍스트 레이블
        _ = createLabel(text: "배터리 용량", top: 336, left: 24)
            boardBatteryTextField = createTextField(placeholder: "배터리 용량을 입력하세요.", top: 330, left: 131)
        boardBatteryTextField.keyboardType = .numberPad
        creatToolbarExitButton(textFieldName: boardBatteryTextField)
        
        
        // 가격 텍스트 레이블
        _ = createLabel(text: "가격", top: 413, left: 46)
            boardPriceTextField = createTextField(placeholder: "분 당 가격을 입력하세요.", top: 410, left: 131)
        boardPriceTextField.keyboardType = .numberPad
        creatToolbarExitButton(textFieldName: boardPriceTextField)
        
        
        // 위치 텍스트 레이블
        _ = createLabel(text: "위치", top: 490, left: 46)
        
        view.addSubview(locationMapView)
        
        
        

        
        // 등록하기 버튼
        registerButton = UIButton(type: .system)
        registerButton?.setTitle("등록하기", for: .normal)
        registerButton?.setTitleColor(UIColor.white, for: .normal)
        registerButton?.backgroundColor = UIColor.systemBlue
        registerButton?.layer.cornerRadius = 10
        registerButton?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(registerButton!)
        
        registerButton?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        registerButton!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        registerButton!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 710),
        registerButton!.widthAnchor.constraint(equalToConstant: 207),
        registerButton!.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    
    @objc func pickerExit()
    {
        self.view.endEditing(true)
    }
    
    
    
    @objc func buttonPressed()
    {
        board.append(Board(boardType: boardType, boardNumber: boardNumber, boardBattery: boardBattery, boardPrice: boardPrice, boardLocation: boardLocation, isAvailable: true))
        
        let alert = UIAlertController(title: "등록 완료", message: "킥보드가 등록되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
        
        print("기종 : \(board[index].boardType), 킥보드 번호 : \(board[index].boardNumber), 배터리 : \(board[index].boardBattery)mAh, 가격 : 분 당 \(board[index].boardPrice)원, 위치 : \(board[index].boardLocation), 대여 가능 여부 : \(board[index].isAvailable)")
        
        index += 1
    }
    
}


extension BoardRegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        boardTypeTextField?.text = pickerList[row]
    }
}

