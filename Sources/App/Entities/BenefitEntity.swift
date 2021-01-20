import Fluent
import Vapor
import BogusApp_Common_Models

final class BenefitEntity: Model, Content {
    static let schema = "benefits"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "type")
    var type: BenefitType

    init() { }
    
    init(_ benefit: Benefit) {
        self.id = benefit.id
        self.name = benefit.name
        self.type = benefit.type
    }

    init(id: UUID, name: String, type: BenefitType) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    func convert() -> Benefit {
        .init(id: id ?? UUID(), name: name, type: type)
    }
}

extension Benefit: Content { }
