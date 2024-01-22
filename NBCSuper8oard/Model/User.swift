//
//  Model.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import Foundation
import NMapsMap

struct User: Codable {
    var id: String
    var password: String
    var name: String
    var phoneNumber: String
    var email: String
    var birthDate: String
    var isRiding: Bool
}
