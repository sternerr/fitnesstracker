//
//  env.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-13.
//
import SwiftUI

protocol ENVProtocol {
    var API_KEY: String { get }
}
    
class BaseENV {
    fileprivate let dict: NSDictionary
    fileprivate enum Key: String {
        case API_KEY
    }
    
    init(resourcesPath: String) {
        if let filePath = Bundle.main.path(forResource: resourcesPath, ofType: "plist") {
            let loadedDict = NSDictionary(contentsOfFile: filePath)
           
            if let loadedDict = loadedDict {
                self.dict = loadedDict
                print(self.dict)
            } else {
                fatalError("Could not load \(resourcesPath).plist")
            }
        } else {
            fatalError("Could not find \(resourcesPath).plist")
        }
    }
}

class EnvConfig: BaseENV, ENVProtocol {
    var API_KEY: String {
        dict.object(forKey: Key.API_KEY.rawValue) as? String ?? ""
    }
    
    init() {
        super.init(resourcesPath: "config")
    }
}


var ENV: ENVProtocol {
    return EnvConfig()
}

