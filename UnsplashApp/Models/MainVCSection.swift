//
//  MainVCSection.swift
//  UnsplashApp
//
//  Created by Mykhailo Romanovskyi on 21.08.2020.
//  Copyright © 2020 Mykhailo Romanovskyi. All rights reserved.
//

import UIKit
struct MainVCSection: Hashable {
//    static func == (lhs: MainVCSection, rhs: MainVCSection) -> Bool {
//        return lhs.uuid == rhs.uuid
//    }
    
  
    
    let uuid = UUID()
    let type: String
    let id: Int
    let items: [MainVCItems]
    

//
//      func hash(into hasher: inout Hasher) {
//          hasher.combine(uuid)
//      }
}
