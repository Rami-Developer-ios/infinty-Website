//
//  File.swift
//  
//
//  Created by Developer IOS on 18/05/2024.
//


import Fluent
import Vapor

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
///
final class User: Model,@unchecked Sendable {
  static let schema = "users"

  @ID
  var id: UUID?
   
  @Field(key: "name")
  var name: String
   
  @Field(key: "username")
  var username: String
    
  init() {}
    
  init(id: UUID? = nil, name: String, username: String) {
    self.name = name
    self.username = username
  }
}
extension User:Content{}
