//
//  DataService_getInfoUserFB.swift
//  MasterCoreData
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import FacebookLogin
import FBSDKLoginKit

class DataService_getInfoUserFB {
    static let shared: DataService_getInfoUserFB = DataService_getInfoUserFB()
    
    func getUserInfo(complete: (User)->Void) {
        let decoded  = UserDefaults.standard.object(forKey: "user") as! Data
        guard let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? User else { return }
        complete(user)
    }
}


