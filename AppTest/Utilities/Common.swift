//
//  Common.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import Foundation

class Common{
    
    static let BASE_URL = "https://reqres.in/api/users"
    
    static var users:[User] = []
    static var utilisateurs:[Utilisateur] = []
    
    static var isUpdated = false
    static var index_row = 0
    static var first_name = ""
    static var last_name = ""
    static var avatar = ""
    static var id: Int16 = 0
    static var email = ""
}

