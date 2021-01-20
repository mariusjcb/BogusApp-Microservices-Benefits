import Foundation
import Fluent
import BogusApp_Common_Models
import Vapor

struct InsertDemoBenefits: Migration {
    let benefits: [Benefit] = [
        
        // Facebook
        .init(id: UUID(), name: "listings", type: .range(3...8)),
        .init(id: UUID(), name: "listings", type: .range(8...15)),
        .init(id: UUID(), name: "listings", type: .range(1...3)),
        .init(id: UUID(), name: "listing", type: .value(1)),
        .init(id: UUID(), name: "optimizations", type: .value(12)),
        .init(id: UUID(), name: "optimizations", type: .value(20)),
        .init(id: UUID(), name: "optimizations", type: .value(8)),
        .init(id: UUID(), name: "Campaign setup", type: .text),
        .init(id: UUID(), name: "Admin and optimising", type: .text),
        .init(id: UUID(), name: "Email support", type: .text),
        .init(id: UUID(), name: "Monthly reports", type: .text),
        .init(id: UUID(), name: "Install", type: .text),
        .init(id: UUID(), name: "Conversion monitoring", type: .text),
        .init(id: UUID(), name: "Landing page", type: .text),
        .init(id: UUID(), name: "Phone support", type: .text),
        .init(id: UUID(), name: "Remarketing", type: .text),
        
            // Linkedin
        .init(id: UUID(), name: "listings", type: .range(5...8)),
        .init(id: UUID(), name: "listings", type: .range(8...10)),
        .init(id: UUID(), name: "listings", type: .range(1...2)),
        .init(id: UUID(), name: "Monitoring", type: .text),
        
        // Twitter
        .init(id: UUID(), name: "listings", type: .range(10...15)),
        .init(id: UUID(), name: "listings", type: .range(15...20)),
        .init(id: UUID(), name: "listings", type: .range(5...10)),
        .init(id: UUID(), name: "listings", type: .range(1...5)),
        .init(id: UUID(), name: "Monitoring", type: .text),
        
        // Instagram
        .init(id: UUID(), name: "listings", type: .range(10...12)),
        .init(id: UUID(), name: "listings", type: .range(1...4)),
        .init(id: UUID(), name: "optimizations", type: .value(4)),
        .init(id: UUID(), name: "optimizations", type: .value(2)),
        .init(id: UUID(), name: "Campaign testing", type: .text),
        .init(id: UUID(), name: "Campaign analysis", type: .text),
        
        // Google AdWords
        .init(id: UUID(), name: "listings", type: .range(10...12)),
        .init(id: UUID(), name: "listings", type: .range(1...4)),
        .init(id: UUID(), name: "optimizations", type: .value(3)),
        .init(id: UUID(), name: "optimizations", type: .value(5)),
        .init(id: UUID(), name: "Campaign creation", type: .text),
        
        // SEO
        .init(id: UUID(), name: "Scope setup", type: .text),
        .init(id: UUID(), name: "Market research", type: .text),
        .init(id: UUID(), name: "Keywords research", type: .text),
        .init(id: UUID(), name: "Hyperlinks analysis", type: .text),
        .init(id: UUID(), name: "Local SEO", type: .text),
        .init(id: UUID(), name: "Audit SEO", type: .text),
        .init(id: UUID(), name: "Website optimisation", type: .text),
        .init(id: UUID(), name: "Backlink setup", type: .text)
    ]
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return benefits
            .map { BenefitEntity($0) }
            .map { $0.save(on: database) }
            .last!
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return benefits
            .map { elem in
                BenefitEntity
                    .query(on: database)
                    .filter(.string("name"), .equal, elem.name)
                    .filter(.string("type"), .equal, elem.type)
                    .delete()
            }.last!
    }
}
