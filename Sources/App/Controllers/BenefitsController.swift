import Fluent
import Vapor
import BogusApp_Common_Models

struct BenefitsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let benefits = routes.grouped("")
        benefits.get(use: index)
        benefits.post(use: create)
        benefits.get("search", use: search)
    }

    func index(req: Request) throws -> EventLoopFuture<[Benefit]> {
        let query = (try? req.query.get(at: "id")) ?? [UUID]()
        return BenefitEntity.query(on: req.db).all().mapEachCompact { (query.isEmpty || query.contains($0.id!)) ? $0.convert() : nil }
    }
    
    func search(req: Request) throws -> EventLoopFuture<[Benefit]> {
        let query = (try? req.query.get(at: "name")) ?? [String]()
        return BenefitEntity.query(on: req.db).all().mapEachCompact { query.contains($0.name) ? $0.convert() : nil }
    }
    
    func create(req: Request) throws -> EventLoopFuture<[Benefit]> {
        let benefits = try req.content.decode([Benefit].self)
        return benefits
            .map { BenefitEntity($0) }
            .map { $0.save(on: req.db) }
            .flatten(on: req.eventLoop)
            .flatMapAlways { _ -> EventLoopFuture<[Benefit]> in
                BenefitEntity.query(on: req.db)
                    .all()
                    .mapEachCompact { ent in benefits.contains(where: { $0.name == ent.name }) ? ent.convert() : nil }
            }
    }
}
