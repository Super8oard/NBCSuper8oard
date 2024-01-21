//
//  DetailViewController.swift
//  memo
//
//  Created by 영현 on 1/21/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedBoard: Board?
    var user: User?
    var isRented: ((Board) -> ())?
    var isHidden: ((Board) -> ())?
    var hideMarker: ((Bool) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let boardImage = UIImageView(frame: CGRect(x: 10, y: 20, width: 100, height: 100))
        boardImage.image = UIImage(named: "BoardPicture")
        view.addSubview(boardImage)
        
        
        let typeLabel = UILabel(frame: CGRect(x: 120, y: 20, width: view.frame.width - 120, height: 20))
        typeLabel.text = "킥보드 종류 : \(selectedBoard?.boardType ?? "")"
        typeLabel.textAlignment = .left
        view.addSubview(typeLabel)
        
        let priceLabel = UILabel(frame: CGRect(x: 120, y: 50, width: view.frame.width - 120, height: 20))
        priceLabel.text = "대여 가격: 분당 \(selectedBoard?.boardPrice ?? 0)₩"
        priceLabel.textAlignment = .left
        view.addSubview(priceLabel)
        
        let isAvailableLabel = UILabel(frame: CGRect(x: 120, y: 80, width: view.frame.width - 120, height: 20))
        isAvailableLabel.text = "대여 가능 여부: \(selectedBoard?.isAvailable ?? false)"
        isAvailableLabel.textAlignment = .left
        view.addSubview(isAvailableLabel)
        
        let rentButton = UIButton(type: .system)
        rentButton.setTitle("대여하기", for: .normal)
        rentButton.tintColor = .white
        rentButton.backgroundColor = .systemBlue
        rentButton.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: 40)
        rentButton.layer.cornerRadius = 10
        rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
        rentButton.isEnabled = selectedBoard?.isAvailable ?? false
        if let user = self.user {
            if user.isRiding {
                rentButton.isEnabled = false
            } else {
                rentButton.isEnabled = true
            }
        }
        view.addSubview(rentButton)
    }
    
    init(selectedBoard: Board? = nil, user: User? = nil) {
        self.selectedBoard = selectedBoard
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rentButtonTapped() {
        let confirmAlert = UIAlertController(title: "대여", message: "선택한 킥보드로 대여를 진행합니다.", preferredStyle: .alert)
        let rentAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            guard var temp = selectedBoard else { return }
//            temp.isAvailable = temp.isAvailable ? false : true
            isRented?(temp)
            isHidden?(temp)
            hideMarker?(temp.isAvailable)
            dismiss(animated: true)
        }
        confirmAlert.addAction(rentAction)
        present(confirmAlert, animated: true)
    }
}
