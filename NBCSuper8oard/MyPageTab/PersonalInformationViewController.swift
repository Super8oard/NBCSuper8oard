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
        
        footerTitles = ["아이디", "전화번호", "이메일", "생일"]
        cellTitles = [userData?.id, userData?.phoneNumber, userData?.email, userData?.birthDate]
    }

    @objc
    private func backButton(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInformationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return footerTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footerTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personalUserCell") as? PersonalUserCell else { return UITableViewCell() }
        cell.detailTextLabel?.text = userData?.id
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return footerTitles[section]
    }
}
