//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//

import Vapor
import Fluent

final class Service:Model,@unchecked Sendable{
 
    
    static let schema = "service"
    
    @ID(key:.id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
//    @Parent(key: "userID")
//    var user: User

    // Unique identifier for this Service.
//    @ID(custom: "foo", generatedBy: .user)
//    var ServesID: Int?
    
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
//        self.ServesID = serviesID
      
//          self.$user.id = userID
    }
    
}
extension Service: Content{}
