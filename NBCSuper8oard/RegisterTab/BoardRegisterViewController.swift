//
//  BoardRegisterViewController.swift
//  NBCSuper8oard
//
//  Created by 석진 on 1/16/24.
//

import UIKit
import NMapsMap
import CoreLocation



class BoardRegisterViewController: UIViewController, UITextFieldDelegate
{
    weak var tabBarVC: TabBarController?
    var board: [Board] = []
    
    var boardType: String = ""
    var boardNumber: Int = 0
    var boardBattery: Int = 0
    var boardPrice: Int = 0
    var boardLocation: NMGLatLng = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
    
    let pickerList: [String] = ["A", "B", "C"]
    
    var boardTypeTextField: UITextField?
    var boardTypePickerView: UIPickerView?
    var boardTypePickerViewExitButton: UIBarButtonItem!
    var boardTypePickerViewToolbar: UIToolbar!
    var boardNumberTextField: UITextField?
    var boardBatteryTextField: UITextField?
    var boardCostTextField: UITextField?
    var registerButton: UIButton?
    
    //let locationManager: LocationProviding = LocationManager()
    
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return true
    }
    
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
        
        else if textField == boardCostTextField
        {
            if let text = textField.text, let unwrapBoardNumber = Int(text)
            {
                self.boardPrice = unwrapBoardNumber
            }
        }
    }
    
    
    func creatExitButton() -> UIBarButtonItem
    {
        let exitButton = UIBarButtonItem()
        
        exitButton.title = "닫기"
        exitButton.target = self
        
        
        return exitButton
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Label 목록
        let title = createLabel(text: "킥보드 등록", top: 77, left: 0)
            title.font = UIFont.systemFont(ofSize: 32)
            NSLayoutConstraint.activate([title.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        let _boardTypeLabel = createLabel(text: "기종", top: 160, left: 46)
        boardTypeTextField = createTextField(placeholder: "기종을 선택해주세요.", top: 154, left: 131)
        boardTypeTextField?.inputView = boardTypePickerView
        
        let boardTypePickerView = UIPickerView()
        boardTypePickerView.delegate = self
        
        boardTypePickerViewExitButton = creatExitButton()
        boardTypePickerViewExitButton.action = #selector(pickerExit)
        boardTypePickerViewToolbar = UIToolbar()
        boardTypePickerViewToolbar.tintColor = .blue
        boardTypePickerViewToolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        boardTypePickerViewToolbar.setItems([boardTypePickerViewExitButton], animated: true)
        
        boardTypeTextField?.inputAccessoryView = boardTypePickerViewToolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        boardTypePickerViewToolbar.setItems([flexSpace, boardTypePickerViewExitButton], animated: true)

        
        let boardNumberLabel = createLabel(text: "킥보드 번호\n(숫자 6자리)", top: 237, left: 19)
            boardNumberLabel.numberOfLines = 2
        boardNumberTextField = createTextField(placeholder: "킥보드 일련번호를 입력하세요.", top: 243, left: 131)
        
        
        let _boardBatteryLabel = createLabel(text: "배터리 용량", top: 336, left: 24)
            boardBatteryTextField = createTextField(placeholder: "배터리 용량을 입력하세요.", top: 330, left: 131)
        
        
        let _boardCostLabel = createLabel(text: "가격", top: 413, left: 46)
            boardCostTextField = createTextField(placeholder: "분 당 가격을 입력하세요.", top: 410, left: 131)
        
        
        let _boardLocationLabel = createLabel(text: "위치", top: 490, left: 46)
        
        
        registerButton = UIButton(type: .system)
        registerButton?.setTitle("추가하기", for: .normal)
        registerButton?.setTitleColor(UIColor.white, for: .normal)
        registerButton?.backgroundColor = UIColor.systemBlue
        registerButton?.layer.cornerRadius = 10
        registerButton?.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(registerButton!)
        
        registerButton?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        registerButton!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        registerButton!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
        registerButton!.widthAnchor.constraint(equalToConstant: 207),
        registerButton!.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        tabBarVC = parent as? TabBarController
    }
    
    
    @objc func keyboardWillShow(notification: Notification)
    {
        // 키보드가 나타날 때 추가하기 버튼을 숨김
        registerButton?.isHidden = true
    }
    
    @objc func keyboardWillHide(notification: Notification) 
    {
        // 키보드가 사라질 때 추가하기 버튼을 보임
        registerButton?.isHidden = false
    }
    
    @objc func pickerExit()
    {
        self.view.endEditing(true)
    }
    
    @objc func buttonPressed()
    {

        board.append(Board(boardType: boardType, boardNumber: boardNumber, boardBattery: boardBattery, boardPrice: boardPrice, boardLocation: NMGLatLng(lat: 37.5670135, lng: 126.9783740), isAvailable: true))
        print("기종 : \(board[0].boardType), 킥보드 번호 : \(board[0].boardNumber), 배터리 : \(board[0].boardBattery)mAh, 가격 : 분 당 \(board[0].boardPrice)원, 위치 : \(board[0].boardLocation), 대여 가능 여부 : \(board[0].isAvailable)")
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
        print(pickerList[row])
    }
}

class LocationManager
{
    
}
