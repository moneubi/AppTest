//
//  User.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import Foundation

typealias Users = [User]
typealias Utilisateurs = [Utilisateur]

struct User: Codable{
    
    var id: Int
    var avatar: String
    var email: String
    var first_name: String
    var last_name: String
    
    init(id: Int, avatar: String, email: String, first_name: String, last_name: String){
        
        self.id = id
        self.avatar = avatar
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
    }
}
