//
//  Model.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import Foundation

//struct User {
//    var id: String
//    var password: String
//    var name: String
//    var phoneNumber: String
//    var email: String
//    var birthDate: String
//}

struct User: Codable {
    var id: String
    var password: String
    var name: String
    var phoneNumber: String
    var email: String
    var birthDate: String
}
