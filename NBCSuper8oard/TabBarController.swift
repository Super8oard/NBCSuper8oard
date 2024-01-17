//
//  TabBarController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.backgroundColor = .white
        
        let mapTab = MapViewController()
        let mapTabItem = UITabBarItem(title: "지도", image: UIImage(named: "MapIcon"), tag: 0)
        mapTab.tabBarItem = mapTabItem
        
        let registerTab = RegisterViewController()
        let registerTabItem = UITabBarItem(title: "킥보드 등록", image: UIImage(named: "KickboardIcon"), tag: 1)
        registerTab.tabBarItem = registerTabItem
        
        let myPageTab = MyPageViewController()
        let myPageTabItem = UITabBarItem(title: "My Page", image: UIImage(named: "MyPageIcon"), tag: 2)
        myPageTab.tabBarItem = myPageTabItem
        
        self.viewControllers = [mapTab, registerTab, myPageTab]
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
