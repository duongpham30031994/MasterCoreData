//
//  User.swift
//  MasterCoreData
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

public class User: NSObject, NSCoding {
    
    struct Key {
        static let name = "Name"
        static let image = "Image"
    }
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name)
        aCoder.encode(image, forKey: Key.image)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Key.name) as? String else { return nil }
        guard let image = aDecoder.decodeObject(forKey: Key.image) as? String else { return nil }
        self.init(name: name, image: image)
    }
}
