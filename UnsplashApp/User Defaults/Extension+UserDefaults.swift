//
//  Extension+UserDefaults.swift
//  UnsplashApp
//
//  Created by Pavel Moroz on 25.09.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import Foundation

extension UserDefaults{

    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    //MARK: Save User Data
    func setUserToken(value: String){
        set(value, forKey: UserDefaultsKeys.userToken.rawValue)
    }

    //MARK: Retrieve User Data
    func getUserToken() -> String{
        return string(forKey: UserDefaultsKeys.userToken.rawValue) ?? ""
    }

    //MARK: Save Order Data
    func setOrderRequest(value: String){
        set(value, forKey: "Order")
    }

    //MARK: Retrieve Order Data
    func getOrderRequest() -> String{
        return string(forKey: "Order") ?? ""
    }
}

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userToken
}
