import Fluent
import BogusApp_Common_Models

struct CreateBenefit: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("benefits")
            .id()
            .field("name", .string, .required)
            .field("type", .json, .required)
            .unique(on: "name", "type")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("benefits").delete()
    }
}
