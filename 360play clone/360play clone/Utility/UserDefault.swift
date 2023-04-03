//
//  UserDefault.swift
//  360play clone
//
//  Created by Ankush Sharma on 27/03/23.
//

import Foundation


struct Defaults {
    
    static let (nameKey, passwordKey) = ("name", "password")
    static let userSessionKey = "userData"
    private static let userDefault = UserDefaults.standard
    
    struct UserDetails {
        let name: String
        let password: String
        
        init(_ userDetails: [String: String]) {
            self.name = userDetails[nameKey] ?? ""
            self.password = userDetails[passwordKey] ?? ""
        }
    }
    
 
    static func save(_ name: String, password: String){
        userDefault.set([nameKey: name, passwordKey: password],
                        forKey: userSessionKey)
        
    }
    
 
    static func getUserDetails()-> UserDetails {
        return UserDetails((userDefault.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }
    

    static func clearUserData(){
        userDefault.removeObject(forKey: userSessionKey)
    }
}
