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

    func setTopicImageURLS(value: [String], key: String) {
        set(value, forKey: key)
    }

    func getTopicImageURLS(key: TopicTitlesKeys) -> [String] {
        //return array(forKey: TopicTitlesKeys.RawValue)
        return stringArray(forKey: key.rawValue) ?? [""]
    }

    func setCurrentTopicID(value: String, key: TopicTitlesKeys) {

        set(value, forKey: key.rawValue)
    }

    func getCurrentTopicID(key: TopicTitlesKeys) -> String {

        return string(forKey: key.rawValue) ?? ""
    }
}

enum UserDefaultsKeys : String {
    
    case isLoggedIn
    case userToken
}

enum TopicTitlesKeys: String {

    case History
    case Athletics
    case Technology
}

