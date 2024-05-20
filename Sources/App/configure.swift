import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "otto.db.elephantsql.com",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "cjzngxyk",
        password: Environment.get("DATABASE_PASSWORD") ?? "Uid2RQwuvffkLTzIEEtAN8jqh3FEb9oc",
        database: Environment.get("DATABASE_NAME") ?? "cjzngxyk",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateTodo())
    
    app.migrations.add(CreateUser())
    app.migrations.add(CreateService())
  
    app.logger.logLevel = .debug

 
    try await app.autoMigrate()

    app.views.use(.leaf)


    // register routes
    try routes(app)
}
