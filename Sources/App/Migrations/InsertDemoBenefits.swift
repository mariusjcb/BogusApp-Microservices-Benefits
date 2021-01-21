import Foundation
import Fluent
import BogusApp_Common_Models
import BogusApp_Common_MockDataProvider
import Vapor

struct InsertDemoBenefits: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return MockData.fetch()!
            .convertAllBenefitsOnly()
            .map { BenefitEntity($0) }
            .map { $0.save(on: database) }
            .last!
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return MockData.fetch()!
            .convertAllBenefitsOnly()
            .map { elem in
                BenefitEntity
                    .query(on: database)
                    .filter(.string("name"), .equal, elem.name)
                    .filter(.string("type"), .equal, elem.type)
                    .delete()
            }.last!
    }
}
