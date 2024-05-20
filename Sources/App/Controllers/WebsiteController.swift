//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.


import Vapor
import Leaf


struct WebsiteController: RouteCollection {

  func boot(routes: RoutesBuilder) throws {

    routes.get(use: {try await indexHandler($0)})
  }

  func indexHandler(_ req: Request) async throws -> View {
      
      let context = IndexContext(title: "Home page")
      
      return try await req.view.render("index",context)
  }
   
}

struct IndexContext: Encodable {
  let title: String
}
