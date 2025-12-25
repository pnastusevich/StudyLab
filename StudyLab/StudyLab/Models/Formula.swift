import SwiftUI

enum Subject: String, CaseIterable, Identifiable, Hashable, Codable {
    case mathematics = "Mathematics"
    case physics = "Physics"
    case chemistry = "Chemistry"
    
    var id: String { rawValue }
}

struct Formula: Identifiable, Codable, Hashable {
    let id: UUID
    let subject: Subject
    let name: String
    let formula: String
    let description: String
    let variables: [Variable]
    
    struct Variable: Identifiable, Codable, Hashable {
        let id: UUID
        let symbol: String
        let name: String
        let description: String
    }
    
    init(id: UUID = UUID(), subject: Subject, name: String, formula: String, description: String, variables: [Variable]) {
        self.id = id
        self.subject = subject
        self.name = name
        self.formula = formula
        self.description = description
        self.variables = variables
    }
}

