import Combine
import SwiftUI

final class ExerciseViewModel: ObservableObject {
    @Published var userAnswer: String = ""
    @Published var isChecked: Bool = false
    @Published var isCorrect: Bool = false
    @Published var showExplanation: Bool = false
    
    let exercise: Exercise
    var progressManager: ProgressManager?
    private let logger = LoggerService()
    
    init(exercise: Exercise, progressManager: ProgressManager? = nil) {
        self.exercise = exercise
        self.progressManager = progressManager
        logger.info("Exercise initialized: \(exercise.question)")
    }
    
    func updateProgressManager(_ manager: ProgressManager) {
        self.progressManager = manager
    }
    
    func checkAnswer() {
        guard let answer = Double(userAnswer.replacingOccurrences(of: ",", with: ".")) else {
            logger.warning("Invalid answer format: \(userAnswer)")
            return
        }
        
        let tolerance = 0.01
        isCorrect = abs(answer - exercise.correctAnswer) < tolerance
        isChecked = true
        showExplanation = true
        
        if isCorrect {
            logger.info("Exercise solved correctly. User answer: \(answer), correct: \(exercise.correctAnswer)")
            progressManager?.incrementSolvedExercises()
        } else {
            logger.info("Exercise solved incorrectly. User answer: \(answer), correct: \(exercise.correctAnswer)")
        }
    }
    
    func reset() {
        userAnswer = ""
        isChecked = false
        isCorrect = false
        showExplanation = false
    }
}

