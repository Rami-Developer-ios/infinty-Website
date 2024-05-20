//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//


import Fluent
import Vapor

struct CreateService: AsyncMigration{
    
    func prepare(on database: Database) async throws {
       
           try await database.schema("service")
            
              .id()
            
              .field("name", .string, .required)
              .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("service").delete()
    }
    
}
