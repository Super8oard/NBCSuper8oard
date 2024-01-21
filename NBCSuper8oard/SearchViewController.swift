//
//  SearchViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/21/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    var currentLatitude: Double?
    var currentLongitude: Double?
    var setCameraLocation: ((Double, Double) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let searchLabel = UILabel(frame: CGRect(x: 10, y: 40, width: view.frame.width - 20, height: 20))
        searchLabel.text = "주소를 입력하세요."
        searchLabel.textAlignment = .left
        searchLabel.layer.cornerRadius = 5
        view.addSubview(searchLabel)
        
        let searchTextField = UITextField(frame: CGRect(x: 10, y: 80, width: view.frame.width - 60, height: 40))
        searchTextField.placeholder = "검색하고 싶은 주소를 입력하세요."
        searchTextField.layer.cornerRadius = 5
        searchTextField.addTarget(self, action: #selector(searchAddress), for: .editingDidEnd)
        view.addSubview(searchTextField)
        
        let searchButton = UIButton(frame: CGRect(x: view.frame.width - 50, y: 80, width: 40, height: 40))
        searchButton.tintColor = .white
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitle("검색", for: .normal)
        searchButton.addTarget(self, action: #selector(moveCamera), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    @objc func moveCamera() {
        print(currentLatitude, currentLongitude)
        if let lat = currentLatitude, let lng = currentLongitude {
            setCameraLocation?(lat, lng)
            dismiss(animated: true)
        } else {
            let cannotMoveAlert = UIAlertController(title: "입력된 주소를 확인해주세요.", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
            cannotMoveAlert.addAction(confirm)
            present(cannotMoveAlert, animated: true)
        }
    }
    
    @objc func searchAddress(_ sender: UITextField) {
        NMGeocoding.shared.getGeoXY(sender.text ?? "") { geoXY in
            if let geoXY = geoXY {
                geoXY.addresses.forEach { address in
                    self.currentLatitude = Double(address.x)
                    self.currentLongitude = Double(address.y)
                    print(address)
                }
            }
        }
    }
}
