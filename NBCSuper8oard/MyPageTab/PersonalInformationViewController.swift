//
//  PersonalInformationViewController.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/17/24.
//

import UIKit

class PersonalInformationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var userData: User?
    
    var footerTitles: [String]?
    var cellTitles: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain, target: self, action: #selector(backButton(_:)))
        
        setUpTableView()
    }

    @objc
    private func backButton(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInformationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return footerTitles?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personalCell") as? PersonalUserCell else { return UITableViewCell() }

        cell.labelValue = cellTitles?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return footerTitles?[section]
    }
}

extension PersonalInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


//MARK: - Helpers
extension PersonalInformationViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        footerTitles = ["아이디", "전화번호", "이메일", "생일"]
        cellTitles = [userData?.id ?? "", userData?.phoneNumber ?? "", userData?.email ?? "", userData?.birthDate ?? ""]
    }
}
