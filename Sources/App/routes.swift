import Vapor

func routes(_ app: Application) throws {
    app.get { _ in
        try index()
    }
}
