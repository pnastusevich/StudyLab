import Foundation

struct Exercise: Identifiable, Hashable {
    let id: UUID
    let formulaId: UUID
    let question: String
    let correctAnswer: Double
    let explanation: String
    let givenValues: [String: Double]
    
    init(id: UUID = UUID(), formulaId: UUID, question: String, correctAnswer: Double, explanation: String, givenValues: [String: Double]) {
        self.id = id
        self.formulaId = formulaId
        self.question = question
        self.correctAnswer = correctAnswer
        self.explanation = explanation
        self.givenValues = givenValues
    }
}

