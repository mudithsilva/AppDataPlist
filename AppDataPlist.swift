//
//  AppDataPlist.swift
//  AppDataPlist
//
//  Created by Mudith Chathuranga on 5/28/18.
//  Copyright © 2018 Chathuranga. All rights reserved.
//

import Foundation

class AppDataPlist {
    
    static let defaults = UserDefaults.standard
    
    static func archiveUserInformation<T : Codable>(info: T) {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(info)
            try data.write(to: self.getPath())
        } catch {
            // Handle error
            print(error)
        }
    }
    
    static func saveUserInformation<T : Codable>(info: T, key: UserData.RawValue) {
        self.archiveUserInformation(info: info)
    }
    
    static func retrieveUserInformation<T : Codable>(key: UserData.RawValue, type: T.Type) -> Any {
        if let data = try? Data(contentsOf: self.getPath()) {
            let decoder = PropertyListDecoder()
            return try! decoder.decode(T.self, from: data)
        } else {
            return ""
        }
    }
    
    
    //Get Path
    static func getPath() -> URL {
        let plistFileName = "Data.plist" // plist name
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        return URL(fileURLWithPath: plistPath)
    }
    
}

enum UserData: String {
    
    case postInfo = "POSTINFO"
    case userInfo = "USERINFO"
    case commentInfo = "COMMENTINFO"
    
    /////// Add Custom name here //////////
}

