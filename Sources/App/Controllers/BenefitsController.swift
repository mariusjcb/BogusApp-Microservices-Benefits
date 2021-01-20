import Fluent
import Vapor
import BogusApp_Common_Models

struct BenefitsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let benefits = routes.grouped("")
        benefits.get(use: index)
        benefits.post(use: create)
        benefits.group(":id") { benefit in
            benefits.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Benefit]> {
        return BenefitEntity.query(on: req.db).all().mapEach { $0.convert() }
    }

    func create(req: Request) throws -> EventLoopFuture<Benefit> {
        guard req.remoteAddress?.hostname == "127.0.0.1" else {
            throw Abort(.forbidden)
        }
        let benefit = try req.content.decode(BenefitEntity.self)
        return benefit.save(on: req.db).map { benefit.convert() }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard req.remoteAddress?.hostname == "127.0.0.1" else {
            throw Abort(.forbidden)
        }
        return BenefitEntity.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
