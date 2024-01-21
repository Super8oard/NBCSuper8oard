//
//  SearchViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/21/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchTextField: UITextField!
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
        
        searchTextField = UITextField(frame: CGRect(x: 10, y: 80, width: view.frame.width - 60, height: 40))
        searchTextField.placeholder = "검색하고 싶은 주소를 입력하세요."
        searchTextField.layer.cornerRadius = 5
        view.addSubview(searchTextField)
        
        let searchButton = UIButton(frame: CGRect(x: view.frame.width - 50, y: 80, width: 40, height: 40))
        searchButton.tintColor = .white
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitle("검색", for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(moveCamera), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
//    @objc func moveCamera() {
//        if let input = searchTextField.text {
//            print(#function, input)
//            NMGeocoding.shared.getGeoXY(input) { geoXY in
//                if let geoXY = geoXY {
//                    geoXY.addresses.forEach { address in
//                        self.currentLatitude = Double(address.x)
//                        self.currentLongitude = Double(address.y)
//                        print(address)
//                    }
//                }
//                print(self.currentLatitude, self.currentLongitude)
//                if let lat = self.currentLatitude, let lng = self.currentLongitude {
//                    self.setCameraLocation?(lat, lng)
//                    self.dismiss(animated: true)
//                } else {
//                    let cannotMoveAlert = UIAlertController(title: "입력된 주소를 확인해주세요.", message: nil, preferredStyle: .alert)
//                    let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
//                    cannotMoveAlert.addAction(confirm)
//                    self.present(cannotMoveAlert, animated: true)
//                }
//            }
//        }
//    } 서울
    @objc func moveCamera() {
        NMGeocoding.shared.getGeoXY(searchTextField.text ?? "") { geoXY in
          if let geoXY = geoXY {
            geoXY.addresses.forEach { address in
              self.currentLatitude = Double(address.y)
              self.currentLongitude = Double(address.x)
              print(address)
            }
          }
          if let lat = self.currentLatitude, let lng = self.currentLongitude {
            self.setCameraLocation?(lat, lng)
            self.dismiss(animated: true)
          } else {
            let cannotMoveAlert = UIAlertController(title: "입력된 주소를 확인해주세요.", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
            cannotMoveAlert.addAction(confirm)
            self.present(cannotMoveAlert, animated: true)
          }
        }
      }
    
//    @objc func searchAddress(_ sender: UITextField) { 부산
//        if let input = sender.text {
//            print(#function, input)
//            NMGeocoding.shared.getGeoXY(input) { geoXY in
//                if let geoXY = geoXY {
//                    geoXY.addresses.forEach { address in
//                        self.currentLatitude = Double(address.x)
//                        self.currentLongitude = Double(address.y)
//                        print(address)
//                    }
//                }
//            }
//        }
//    }
}

