import Foundation
import Combine

final class ProgressManager: ObservableObject {
    @Published var progressState: ProgressState
    
    private let userDefaultsKey = "StudyLabProgress"
    private let logger = LoggerService()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode(ProgressState.self, from: data) {
            self.progressState = decoded
            logger.info("ProgressState loaded from UserDefaults: \(progressState.viewedFormulasCount) formulas, \(progressState.calculationsCount) calculations, \(progressState.solvedExercisesCount) exercises")
        } else {
            self.progressState = ProgressState()
            logger.info("ProgressState initialized as new")
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(progressState) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            logger.debug("ProgressState saved to UserDefaults")
        } else {
            logger.error("Failed to encode ProgressState")
        }
    }
    
    func markFormulaViewed(_ formulaId: UUID) {
        if !progressState.viewedFormulas.contains(formulaId) {
            progressState.viewedFormulas.insert(formulaId)
            progressState.viewedFormulasCount += 1
            logger.info("Formula viewed: \(formulaId). Total: \(progressState.viewedFormulasCount)")
            save()
        }
    }
    
    func incrementCalculations() {
        progressState.calculationsCount += 1
        logger.info("Calculation performed. Total: \(progressState.calculationsCount)")
        save()
    }
    
    func incrementSolvedExercises() {
        progressState.solvedExercisesCount += 1
        logger.info("Exercise solved. Total: \(progressState.solvedExercisesCount)")
        save()
    }
    
    func resetProgress() {
        logger.warning("Progress reset requested")
        progressState.reset()
        save()
        logger.info("Progress reset completed")
    }
}

