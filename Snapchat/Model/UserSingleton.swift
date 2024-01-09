//
//  UserSingleton.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 27.12.2023.
//

import Foundation

class UserSingleton {
    static let sharedUserInfo = UserSingleton()
    var email: String?
    var userName: String?
    private init(){
    }
}
