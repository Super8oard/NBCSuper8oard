//
//  BoardRegisterViewController.swift
//  NBCSuper8oard
//
//  Created by 석진 on 1/16/24.
//

import UIKit
import NMapsMap

class BoardRegisterViewController: UIViewController, UITextFieldDelegate {
    
    
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
        textField.delegate = self
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: left),
        ])
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            // 키보드의 'Return' 버튼이 눌렸을 때 호출되는 메서드
            textField.resignFirstResponder() // 키보드 숨김
            return true
        }
        
        return textField
    }
    
    func createPickerView(pickerList: [String], top: CGFloat, left: CGFloat) -> UIPickerView
    {
        let pickerView = UIPickerView()
        let pickerList = pickerList
    

        
        func Component(in pickerView: UIPickerView) -> Int
        {
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
        
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top),
            pickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: left),
        ])
        
        
        return pickerView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Label 목록
        let title = createLabel(text: "킥보드 등록", top: 77, left: 0)
            title.font = UIFont.systemFont(ofSize: 32)
            NSLayoutConstraint.activate([title.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        let boardTypeLabel = createLabel(text: "기종", top: 209, left: 46)
        let boardNumberLabel = createLabel(text: "킥보드 번호\n(숫자 6자리)", top: 286, left: 19)
            boardNumberLabel.numberOfLines = 2
        let boardBatteryLabel = createLabel(text: "배터리 용량", top: 385, left: 24)
        let boardCostLabel = createLabel(text: "가격", top: 462, left: 46)
        let boardLocationLabel = createLabel(text: "위치", top: 539, left: 46)
        
        
        // TextField 목록
        let boardNumber = createTextField(placeholder: "킥보드 일련번호를 입력하세요.", top: 292, left: 131)
        
        // PickerView 목록
        let boardType = createPickerView(pickerList: ["A", "B", "C"], top: 112, left: 100)
        
    }
    
    let a = NMGLatLng(lat: 35.4, lng: 125.7)
}
