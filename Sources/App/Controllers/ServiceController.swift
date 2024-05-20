//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//
import Vapor

struct ServiceController: RouteCollection {
    // 2
    func boot(routes: RoutesBuilder) throws {
        // 3
        let serviceRoute = routes.grouped("api", "service")
        // 4
        serviceRoute.post(use: {try await createHandler($0)})
        
        serviceRoute.get(use: {try await getAllHandler($0)})
        
        serviceRoute.get(":serviceID", use:{ try await getHandler($0)})
    }
    
    // 5
    func createHandler(_ req: Request) async throws -> Service {
        // 6
        let service = try req.content.decode(Service.self)
        // 7
        try await service.save(on: req.db)
        
        return service
    }
    
    // 1
    func getAllHandler(_ req: Request) async throws -> [Service] {
        // 2
        return try await Service.query(on: req.db).all()
    }
    
    // 3
    func getHandler(_ req: Request) async throws -> Service {
        
        guard let user = try await Service.find(req.parameters.get("userID"), on: req.db) else{
            throw Abort(.notFound)
        }
        return user
    }
}

