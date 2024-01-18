//
//  UserStore.swift
//  NBCSuper8oard
//
//  Created by 洪立妍 on 1/17/24.
//

import Foundation

// Function to save user to UserDefaults using encoding
func saveUserToUserDefaults(_ user: User, forKey key: String) {
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(user) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: key)
    }
}

// Function to retrieve user from UserDefaults using decoding
// 在 retrieveUserFromUserDefaults 函数的基础上稍作修改，使其可以根据 ID 获取用户信息

func retrieveUserFromUserDefaults(forKey key: String) -> User? {
    let userDefaults = UserDefaults.standard
    if let encodedData = userDefaults.data(forKey: key) {
        let decoder = JSONDecoder()
        if let decodedUser = try? decoder.decode(User.self, from: encodedData) {
            return decodedUser
        }
    }
    return nil
}
