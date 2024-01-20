//
//  DetailViewController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedBoard: Board?
    var isRented: ((Board) -> ())?
    var isHidden: ((Board) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let boardImage = UIImageView(frame: CGRect(x: 10, y: 20, width: 100, height: 100))
        boardImage.image = UIImage(named: "BoardPicture")
        view.addSubview(boardImage)
        
        
        let typeLabel = UILabel(frame: CGRect(x: 120, y: 20, width: view.frame.width - 120, height: 20))
        typeLabel.text = selectedBoard?.boardType
        typeLabel.textAlignment = .left
        view.addSubview(typeLabel)
        
        let priceLabel = UILabel(frame: CGRect(x: 120, y: 50, width: view.frame.width - 120, height: 20))
        priceLabel.text = "\(selectedBoard?.boardPrice ?? 0)"
        priceLabel.textAlignment = .left
        view.addSubview(priceLabel)
        
        let isAvailableLabel = UILabel(frame: CGRect(x: 120, y: 80, width: view.frame.width - 120, height: 20))
        isAvailableLabel.text = "\(selectedBoard?.isAvailable ?? false)"
        isAvailableLabel.textAlignment = .left
        view.addSubview(isAvailableLabel)
        
        let rentButton = UIButton(type: .system)
        rentButton.setTitle("대여하기", for: .normal)
        rentButton.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: 40)
        rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
        rentButton.isEnabled = selectedBoard?.isAvailable ?? false
        view.addSubview(rentButton)
    }
    
    init(selectedBoard: Board? = nil) {
        self.selectedBoard = selectedBoard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func rentButtonTapped() {
        let confirmAlert = UIAlertController(title: "대여", message: "선택한 킥보드로 대여를 진행합니다.", preferredStyle: .alert)
        let rentAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            guard var temp = selectedBoard else { return }
            temp.isAvailable = temp.isAvailable ? false : true
            isRented?(temp)
            isHidden?(temp)
            dismiss(animated: true)
        }
        confirmAlert.addAction(rentAction)
        present(confirmAlert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
