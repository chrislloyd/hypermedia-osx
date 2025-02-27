import Foundation
import HtmlVaporSupport
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = try await Application.make(env)
try await configure(app)
try await app.execute()
