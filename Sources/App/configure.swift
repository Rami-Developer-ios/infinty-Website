import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    
    if let databaseURL = Environment.get("DATABASE_URL") {
        
        var tlsConfig: TLSConfiguration = .makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        let nioSSLContext = try NIOSSLContext(configuration: tlsConfig)

        var postgresConfig = try SQLPostgresConfiguration(url: databaseURL)
        postgresConfig.coreConfiguration.tls = .require(nioSSLContext)

        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "postgres",
            password: Environment.get("DATABASE_PASSWORD") ?? "r315r199r",
            database: Environment.get("DATABASE_NAME") ?? "postgres",
            tls: .prefer(try .init(configuration: .clientDefault)))
        ), as: .psql)
    }
    app.migrations.add(CreateTodo())
    
    app.migrations.add(CreateUser())
    app.migrations.add(CreateService())
  
    app.logger.logLevel = .debug

 
    try await app.autoMigrate()

    app.views.use(.leaf)


    // register routes
    try routes(app)
}
