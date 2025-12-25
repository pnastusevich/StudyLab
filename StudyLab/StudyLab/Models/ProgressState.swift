import Combine
import SwiftUI

class ProgressState: ObservableObject, Codable {
    @Published var viewedFormulasCount: Int
    @Published var calculationsCount: Int
    @Published var solvedExercisesCount: Int
    @Published var viewedFormulas: Set<UUID>
    
    enum CodingKeys: String, CodingKey {
        case viewedFormulasCount
        case calculationsCount
        case solvedExercisesCount
        case viewedFormulas
    }
    
    init(viewedFormulasCount: Int = 0, 
         calculationsCount: Int = 0, 
         solvedExercisesCount: Int = 0,
         viewedFormulas: Set<UUID> = []) {
        self.viewedFormulasCount = viewedFormulasCount
        self.calculationsCount = calculationsCount
        self.solvedExercisesCount = solvedExercisesCount
        self.viewedFormulas = viewedFormulas
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        viewedFormulasCount = try container.decode(Int.self, forKey: .viewedFormulasCount)
        calculationsCount = try container.decode(Int.self, forKey: .calculationsCount)
        solvedExercisesCount = try container.decode(Int.self, forKey: .solvedExercisesCount)
        viewedFormulas = try container.decode(Set<UUID>.self, forKey: .viewedFormulas)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(viewedFormulasCount, forKey: .viewedFormulasCount)
        try container.encode(calculationsCount, forKey: .calculationsCount)
        try container.encode(solvedExercisesCount, forKey: .solvedExercisesCount)
        try container.encode(viewedFormulas, forKey: .viewedFormulas)
    }
    
    func reset() {
        viewedFormulasCount = 0
        calculationsCount = 0
        solvedExercisesCount = 0
        viewedFormulas = []
    }
    
    struct Achievement: Identifiable {
        let id: String
        let name: String
        let description: String
        let isEarned: Bool
    }
    
    func getAllAchievements() -> [Achievement] {
        var achievements: [Achievement] = []
        
        achievements.append(Achievement(id: "first_formula", name: "First Formula", description: "View your first formula", isEarned: viewedFormulasCount >= 1))
        achievements.append(Achievement(id: "curious", name: "Curious", description: "View 5 formulas", isEarned: viewedFormulasCount >= 5))
        achievements.append(Achievement(id: "formula_expert", name: "Formula Expert", description: "View 10 formulas", isEarned: viewedFormulasCount >= 10))
        achievements.append(Achievement(id: "erudite", name: "Erudite", description: "View 20 formulas", isEarned: viewedFormulasCount >= 20))
        achievements.append(Achievement(id: "formula_master", name: "Formula Master", description: "View 30 formulas", isEarned: viewedFormulasCount >= 30))
        achievements.append(Achievement(id: "formula_legend", name: "Formula Legend", description: "View 50 formulas", isEarned: viewedFormulasCount >= 50))
        
        achievements.append(Achievement(id: "first_calculation", name: "First Calculation", description: "Perform your first calculation", isEarned: calculationsCount >= 1))
        achievements.append(Achievement(id: "beginner_calculator", name: "Beginner Calculator", description: "Perform 5 calculations", isEarned: calculationsCount >= 5))
        achievements.append(Achievement(id: "active_calculator", name: "Active Calculator", description: "Perform 10 calculations", isEarned: calculationsCount >= 10))
        achievements.append(Achievement(id: "calculation_master", name: "Calculation Master", description: "Perform 20 calculations", isEarned: calculationsCount >= 20))
        achievements.append(Achievement(id: "calculation_virtuoso", name: "Calculation Virtuoso", description: "Perform 50 calculations", isEarned: calculationsCount >= 50))
        achievements.append(Achievement(id: "calculation_genius", name: "Calculation Genius", description: "Perform 100 calculations", isEarned: calculationsCount >= 100))
        
        achievements.append(Achievement(id: "first_exercise", name: "First Exercise", description: "Solve your first exercise", isEarned: solvedExercisesCount >= 1))
        achievements.append(Achievement(id: "beginner_solver", name: "Beginner Solver", description: "Solve 5 exercises", isEarned: solvedExercisesCount >= 5))
        achievements.append(Achievement(id: "experienced_solver", name: "Experienced Solver", description: "Solve 10 exercises", isEarned: solvedExercisesCount >= 10))
        achievements.append(Achievement(id: "solver", name: "Solver", description: "Solve 15 exercises", isEarned: solvedExercisesCount >= 15))
        achievements.append(Achievement(id: "exercise_master", name: "Exercise Master", description: "Solve 25 exercises", isEarned: solvedExercisesCount >= 25))
        achievements.append(Achievement(id: "great_solver", name: "Great Solver", description: "Solve 50 exercises", isEarned: solvedExercisesCount >= 50))
        achievements.append(Achievement(id: "legendary_solver", name: "Legendary Solver", description: "Solve 100 exercises", isEarned: solvedExercisesCount >= 100))
        
        achievements.append(Achievement(id: "well_rounded", name: "Well-Rounded Student", description: "5 formulas, 10 calculations, 5 exercises", isEarned: viewedFormulasCount >= 5 && calculationsCount >= 10 && solvedExercisesCount >= 5))
        achievements.append(Achievement(id: "universal_knower", name: "Universal Knower", description: "15 formulas, 25 calculations, 15 exercises", isEarned: viewedFormulasCount >= 15 && calculationsCount >= 25 && solvedExercisesCount >= 15))
        achievements.append(Achievement(id: "master_of_all", name: "Master of All Sciences", description: "30 formulas, 50 calculations, 30 exercises", isEarned: viewedFormulasCount >= 30 && calculationsCount >= 50 && solvedExercisesCount >= 30))
        achievements.append(Achievement(id: "absolute_champion", name: "Absolute Champion", description: "50 formulas, 100 calculations, 50 exercises", isEarned: viewedFormulasCount >= 50 && calculationsCount >= 100 && solvedExercisesCount >= 50))
        
        achievements.append(Achievement(id: "practitioner", name: "Practitioner", description: "10 calculations and 10 exercises", isEarned: calculationsCount >= 10 && solvedExercisesCount >= 10))
        achievements.append(Achievement(id: "theorist_practitioner", name: "Theorist and Practitioner", description: "20 formulas and 20 exercises", isEarned: viewedFormulasCount >= 20 && solvedExercisesCount >= 20))
        achievements.append(Achievement(id: "tireless_student", name: "Tireless Student", description: "30 calculations and 30 exercises", isEarned: calculationsCount >= 30 && solvedExercisesCount >= 30))
        
        return achievements
    }
    
    func getAchievements() -> [String] {
        return getAllAchievements().filter { $0.isEarned }.map { $0.name }
    }
}

