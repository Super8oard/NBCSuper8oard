//
//  Scooter.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/17/24.
//

import Foundation
import NMapsMap

struct Board {
    let boardType: String
    let boardNumber: Int
    var boardBattery: Int
    let boardPrice: Int
    var boardLocation: NMGLatLng
    var isAvailable: Bool {
        get {
            boardBattery > 30
        }
    }
    
    init(boardType: String, boardNumber: Int, boardBattery: Int, boardPrice: Int, boardLocation: NMGLatLng, isAvailable: Bool) {
        self.boardType = boardType
        self.boardNumber = boardNumber
        self.boardBattery = boardBattery
        self.boardPrice = boardPrice
        self.boardLocation = boardLocation
    }
}
