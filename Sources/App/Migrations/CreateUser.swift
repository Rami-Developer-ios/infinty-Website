//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//

import Fluent
import Vapor

struct CreateUser: AsyncMigration{
    func prepare(on database: Database) async throws {
       
           try await database.schema("users")
            
              .id()
            
              .field("name", .string, .required)
              .field("username", .string, .required)
            
              .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
    
}
