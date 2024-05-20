//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//

import Foundation
import Vapor


struct UsersController: RouteCollection {
  
    func boot(routes: RoutesBuilder) throws {
     
        let usersRoute = routes.grouped("api", "users")
      
        usersRoute.post(use: {try await createHandler($0)})
        
        usersRoute.get(use: {try await getAllHandler($0)})
        
        usersRoute.get(":userID", use:{ try await getHandler($0)})
    }
    
  
    func createHandler(_ req: Request) async throws -> User {
      
        let user = try req.content.decode(User.self)
      
        try await user.save(on: req.db)
        
        return user
    }
    
 
    func getAllHandler(_ req: Request) async throws -> [User] {
      
        return try await User.query(on: req.db).all()
    }
    
 
    func getHandler(_ req: Request) async throws -> User {
        
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else{
            throw Abort(.notFound)
        }
        return user
    }
}
