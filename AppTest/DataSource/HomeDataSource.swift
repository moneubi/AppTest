//
//  HomeDataSource.swift
//  AppTest
//
//  Created by MBAYE Libasse on 14/6/2022.
//

import Foundation
import SwiftyJSON
import CoreData

protocol HomeDataSourceProtocol{
    
    func getUsers(completion: @escaping (_ success: Bool, _ results: Users?, _ error: String?) -> ())
}

class HomeDataSource: HomeDataSourceProtocol{
    
    func getUsers(completion: @escaping (Bool, Users?, String?) -> ()) {
        
        HttpRequestHelper().GET(url: Common.BASE_URL, params: [:], httpHeader: .application_json, complete: {success, data in
            
            if success {
                let json = JSON(data as Any)
                let jArray = json["data"].array
                var jUser: JSON
                var user: User
                
                for i in 1...jArray!.count {
                    
                    jUser = JSON(jArray?[i - 1] as Any)
                    user = User(id: jUser["id"].intValue, avatar: jUser["avatar"].stringValue, email: jUser["email"].stringValue, first_name: jUser["first_name"].stringValue, last_name: jUser["last_name"].stringValue)
                    
                    Common.users.append(user)
                }
                if Common.users.count > 0{
                    
                    completion(true, Common.users, nil)
                }else{
                    
                    completion(false, nil, "Error: Trying to parse Users to model")
                }
            } else {
                 
                completion(false, nil, "Error: Users GET Request failed")
            }
            
        })
    }
}

