//
//  Model.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import Foundation
import NMapsMap

struct User {
    var id: String
    var password: String
    var name: String
    var phoneNumber: String
    var email: String
    var birthDate: String
}


// 킥보드 등록 구조체
struct Board {
    var boardType: String
    var boardNumber: Int
    var boardBattery: Int
    var boardCost: Int
    var boardLocation: NMGLatLng
    var isAvilable: Bool
}
