import Combine
import SwiftUI

final class FormulasViewModel: ObservableObject {
    @Published var selectedSubject: Subject = .mathematics
    @Published var formulas: [Formula] = []
    
    var progressManager: ProgressManager?
    private let logger = LoggerService()
    
    init(progressManager: ProgressManager? = nil) {
        self.progressManager = progressManager
        loadFormulas()
    }
    
    func updateProgressManager(_ manager: ProgressManager) {
        self.progressManager = manager
    }
    
    var filteredFormulas: [Formula] {
        formulas.filter { $0.subject == selectedSubject }
    }
    
    func loadFormulas() {
        logger.info("Loading formulas")
        formulas = [
            Formula(
                subject: .mathematics,
                name: "Circle Area",
                formula: "S = π × r²",
                description: "Formula for calculating the area of a circle by radius",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "S", name: "Area", description: "Area of the circle"),
                    Formula.Variable(id: UUID(), symbol: "π", name: "Pi", description: "Mathematical constant, approximately 3.14159"),
                    Formula.Variable(id: UUID(), symbol: "r", name: "Radius", description: "Distance from the center of the circle to its edge")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Rectangle Perimeter",
                formula: "P = 2 × (a + b)",
                description: "Formula for calculating the perimeter of a rectangle",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "P", name: "Perimeter", description: "Sum of all sides of the rectangle"),
                    Formula.Variable(id: UUID(), symbol: "a", name: "Length", description: "Length of the rectangle"),
                    Formula.Variable(id: UUID(), symbol: "b", name: "Width", description: "Width of the rectangle")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Quadratic Equation",
                formula: "ax² + bx + c = 0",
                description: "General form of a quadratic equation",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "a", name: "Coefficient a", description: "Coefficient of x²"),
                    Formula.Variable(id: UUID(), symbol: "b", name: "Coefficient b", description: "Coefficient of x"),
                    Formula.Variable(id: UUID(), symbol: "c", name: "Constant term", description: "Constant term of the equation")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Triangle Area",
                formula: "S = (a × h) / 2",
                description: "Formula for calculating the area of a triangle",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "S", name: "Area", description: "Area of the triangle"),
                    Formula.Variable(id: UUID(), symbol: "a", name: "Base", description: "Length of the triangle base"),
                    Formula.Variable(id: UUID(), symbol: "h", name: "Height", description: "Height of the triangle dropped to the base")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Parallelepiped Volume",
                formula: "V = a × b × c",
                description: "Formula for calculating the volume of a rectangular parallelepiped",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Volume of the parallelepiped"),
                    Formula.Variable(id: UUID(), symbol: "a", name: "Length", description: "Length of the parallelepiped"),
                    Formula.Variable(id: UUID(), symbol: "b", name: "Width", description: "Width of the parallelepiped"),
                    Formula.Variable(id: UUID(), symbol: "c", name: "Height", description: "Height of the parallelepiped")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Pythagorean Theorem",
                formula: "a² + b² = c²",
                description: "Pythagorean theorem for a right triangle",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "a", name: "Leg a", description: "First leg of the right triangle"),
                    Formula.Variable(id: UUID(), symbol: "b", name: "Leg b", description: "Second leg of the right triangle"),
                    Formula.Variable(id: UUID(), symbol: "c", name: "Hypotenuse", description: "Hypotenuse of the right triangle")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Trapezoid Area",
                formula: "S = ((a + b) × h) / 2",
                description: "Formula for calculating the area of a trapezoid",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "S", name: "Area", description: "Area of the trapezoid"),
                    Formula.Variable(id: UUID(), symbol: "a", name: "Base a", description: "First base of the trapezoid"),
                    Formula.Variable(id: UUID(), symbol: "b", name: "Base b", description: "Second base of the trapezoid"),
                    Formula.Variable(id: UUID(), symbol: "h", name: "Height", description: "Height of the trapezoid")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Cylinder Volume",
                formula: "V = π × r² × h",
                description: "Formula for calculating the volume of a cylinder",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Volume of the cylinder"),
                    Formula.Variable(id: UUID(), symbol: "π", name: "Pi", description: "Mathematical constant"),
                    Formula.Variable(id: UUID(), symbol: "r", name: "Radius", description: "Radius of the cylinder base"),
                    Formula.Variable(id: UUID(), symbol: "h", name: "Height", description: "Height of the cylinder")
                ]
            ),
            Formula(
                subject: .mathematics,
                name: "Sphere Surface Area",
                formula: "S = 4 × π × r²",
                description: "Formula for calculating the surface area of a sphere",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "S", name: "Area", description: "Surface area of the sphere"),
                    Formula.Variable(id: UUID(), symbol: "π", name: "Pi", description: "Mathematical constant"),
                    Formula.Variable(id: UUID(), symbol: "r", name: "Radius", description: "Radius of the sphere")
                ]
            ),
            
            Formula(
                subject: .physics,
                name: "Speed",
                formula: "v = s / t",
                description: "Formula for calculating speed in uniform motion",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "v", name: "Speed", description: "Speed of motion, measured in m/s"),
                    Formula.Variable(id: UUID(), symbol: "s", name: "Distance", description: "Distance traveled, measured in meters"),
                    Formula.Variable(id: UUID(), symbol: "t", name: "Time", description: "Time of motion, measured in seconds")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Force",
                formula: "F = m × a",
                description: "Newton's second law: force equals mass times acceleration",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "F", name: "Force", description: "Force, measured in Newtons (N)"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Body mass, measured in kilograms (kg)"),
                    Formula.Variable(id: UUID(), symbol: "a", name: "Acceleration", description: "Acceleration, measured in m/s²")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Kinetic Energy",
                formula: "E = (m × v²) / 2",
                description: "Formula for calculating the kinetic energy of a moving body",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "E", name: "Energy", description: "Kinetic energy, measured in Joules (J)"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Body mass, measured in kilograms (kg)"),
                    Formula.Variable(id: UUID(), symbol: "v", name: "Velocity", description: "Body velocity, measured in m/s")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Potential Energy",
                formula: "E = m × g × h",
                description: "Formula for calculating the potential energy of a body in a gravitational field",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "E", name: "Energy", description: "Potential energy, measured in Joules (J)"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Body mass, measured in kilograms (kg)"),
                    Formula.Variable(id: UUID(), symbol: "g", name: "Gravitational acceleration", description: "Gravitational acceleration, approximately 9.8 m/s²"),
                    Formula.Variable(id: UUID(), symbol: "h", name: "Height", description: "Height above reference level, measured in meters")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Momentum",
                formula: "p = m × v",
                description: "Formula for calculating the momentum of a body",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "p", name: "Momentum", description: "Body momentum, measured in kg·m/s"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Body mass, measured in kilograms (kg)"),
                    Formula.Variable(id: UUID(), symbol: "v", name: "Velocity", description: "Body velocity, measured in m/s")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Work",
                formula: "A = F × s",
                description: "Formula for calculating work done by a force",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "A", name: "Work", description: "Work done by force, measured in Joules (J)"),
                    Formula.Variable(id: UUID(), symbol: "F", name: "Force", description: "Force, measured in Newtons (N)"),
                    Formula.Variable(id: UUID(), symbol: "s", name: "Distance", description: "Displacement, measured in meters")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Power",
                formula: "P = A / t",
                description: "Formula for calculating power",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "P", name: "Power", description: "Power, measured in Watts (W)"),
                    Formula.Variable(id: UUID(), symbol: "A", name: "Work", description: "Work, measured in Joules (J)"),
                    Formula.Variable(id: UUID(), symbol: "t", name: "Time", description: "Time to perform work, measured in seconds")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Density",
                formula: "ρ = m / V",
                description: "Formula for calculating the density of a substance",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "ρ", name: "Density", description: "Substance density, measured in kg/m³"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Substance mass, measured in kilograms (kg)"),
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Substance volume, measured in m³")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Pressure",
                formula: "p = F / S",
                description: "Formula for calculating pressure",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "p", name: "Pressure", description: "Pressure, measured in Pascals (Pa)"),
                    Formula.Variable(id: UUID(), symbol: "F", name: "Force", description: "Force, measured in Newtons (N)"),
                    Formula.Variable(id: UUID(), symbol: "S", name: "Area", description: "Surface area, measured in m²")
                ]
            ),
            Formula(
                subject: .physics,
                name: "Ohm's Law",
                formula: "U = I × R",
                description: "Ohm's law for a circuit section",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "U", name: "Voltage", description: "Voltage, measured in Volts (V)"),
                    Formula.Variable(id: UUID(), symbol: "I", name: "Current", description: "Current, measured in Amperes (A)"),
                    Formula.Variable(id: UUID(), symbol: "R", name: "Resistance", description: "Resistance, measured in Ohms (Ω)")
                ]
            ),
            
            Formula(
                subject: .chemistry,
                name: "Amount of Substance",
                formula: "n = m / M",
                description: "Formula for calculating the amount of substance",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "n", name: "Amount of substance", description: "Amount of substance, measured in moles (mol)"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Substance mass, measured in grams (g)"),
                    Formula.Variable(id: UUID(), symbol: "M", name: "Molar mass", description: "Molar mass of substance, measured in g/mol")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Solution Concentration",
                formula: "C = n / V",
                description: "Formula for calculating the molar concentration of a solution",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "C", name: "Concentration", description: "Molar concentration, measured in mol/L"),
                    Formula.Variable(id: UUID(), symbol: "n", name: "Amount of substance", description: "Amount of substance, measured in moles (mol)"),
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Solution volume, measured in liters (L)")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Mass Fraction",
                formula: "ω = (m₁ / m) × 100%",
                description: "Formula for calculating the mass fraction of a substance in a solution",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "ω", name: "Mass fraction", description: "Mass fraction of substance, measured in percent (%)"),
                    Formula.Variable(id: UUID(), symbol: "m₁", name: "Substance mass", description: "Mass of dissolved substance, measured in grams (g)"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Solution mass", description: "Total solution mass, measured in grams (g)")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Volume Fraction",
                formula: "φ = (V₁ / V) × 100%",
                description: "Formula for calculating the volume fraction of a substance in a mixture",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "φ", name: "Volume fraction", description: "Volume fraction of substance, measured in percent (%)"),
                    Formula.Variable(id: UUID(), symbol: "V₁", name: "Substance volume", description: "Component volume, measured in liters (L)"),
                    Formula.Variable(id: UUID(), symbol: "V", name: "Mixture volume", description: "Total mixture volume, measured in liters (L)")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Avogadro's Law",
                formula: "V = n × Vₘ",
                description: "Avogadro's law: equal volumes of gases contain the same number of molecules",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "V", name: "Gas volume", description: "Gas volume, measured in liters (L)"),
                    Formula.Variable(id: UUID(), symbol: "n", name: "Amount of substance", description: "Amount of substance, measured in moles (mol)"),
                    Formula.Variable(id: UUID(), symbol: "Vₘ", name: "Molar volume", description: "Molar volume of gas at STP, equals 22.4 L/mol")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Substance Density",
                formula: "ρ = m / V",
                description: "Formula for calculating the density of a substance",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "ρ", name: "Density", description: "Substance density, measured in g/cm³ or g/mL"),
                    Formula.Variable(id: UUID(), symbol: "m", name: "Mass", description: "Substance mass, measured in grams (g)"),
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Substance volume, measured in cm³ or mL")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Product Yield",
                formula: "η = (mₚ / mₜ) × 100%",
                description: "Formula for calculating the yield of a reaction product",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "η", name: "Product yield", description: "Product yield, measured in percent (%)"),
                    Formula.Variable(id: UUID(), symbol: "mₚ", name: "Practical mass", description: "Practically obtained product mass, measured in grams (g)"),
                    Formula.Variable(id: UUID(), symbol: "mₜ", name: "Theoretical mass", description: "Theoretically calculated product mass, measured in grams (g)")
                ]
            ),
            Formula(
                subject: .chemistry,
                name: "Equivalent Molar Concentration",
                formula: "Cₑ = nₑ / V",
                description: "Formula for calculating the equivalent molar concentration",
                variables: [
                    Formula.Variable(id: UUID(), symbol: "Cₑ", name: "Equivalent concentration", description: "Equivalent molar concentration, measured in mol/L"),
                    Formula.Variable(id: UUID(), symbol: "nₑ", name: "Amount of equivalents", description: "Amount of substance equivalents, measured in mol-equiv"),
                    Formula.Variable(id: UUID(), symbol: "V", name: "Volume", description: "Solution volume, measured in liters (L)")
                ]
            )
        ]
        logger.info("Loaded \(formulas.count) formulas: \(formulas.filter { $0.subject == .mathematics }.count) math, \(formulas.filter { $0.subject == .physics }.count) physics, \(formulas.filter { $0.subject == .chemistry }.count) chemistry")
    }
    
    func markFormulaViewed(_ formula: Formula) {
        logger.info("Marking formula as viewed: \(formula.name) (\(formula.subject.rawValue))")
        progressManager?.markFormulaViewed(formula.id)
    }
    
    func generateExercise(for formula: Formula) -> Exercise {
        logger.info("Generating exercise for formula: \(formula.name)")
        switch formula.name {
        case "Circle Area":
            let r = Double.random(in: 1...10)
            let correctAnswer = Double.pi * r * r
            return Exercise(
                formulaId: formula.id,
                question: "Calculate the area of a circle with radius \(String(format: "%.1f", r)) m.",
                correctAnswer: correctAnswer,
                explanation: "We use the formula S = π × r². Substituting: S = π × \(String(format: "%.1f", r))² = \(String(format: "%.2f", correctAnswer)) m²",
                givenValues: ["r": r]
            )
        case "Speed":
            let s = Double.random(in: 10...100)
            let t = Double.random(in: 2...20)
            let correctAnswer = s / t
            return Exercise(
                formulaId: formula.id,
                question: "A body traveled a distance of \(String(format: "%.1f", s)) m in \(String(format: "%.1f", t)) s. Find the speed.",
                correctAnswer: correctAnswer,
                explanation: "We use the formula v = s / t. Substituting: v = \(String(format: "%.1f", s)) / \(String(format: "%.1f", t)) = \(String(format: "%.2f", correctAnswer)) m/s",
                givenValues: ["s": s, "t": t]
            )
        case "Force":
            let m = Double.random(in: 1...50)
            let a = Double.random(in: 1...10)
            let correctAnswer = m * a
            return Exercise(
                formulaId: formula.id,
                question: "A body with mass \(String(format: "%.1f", m)) kg moves with acceleration \(String(format: "%.1f", a)) m/s². Find the force.",
                correctAnswer: correctAnswer,
                explanation: "We use the formula F = m × a. Substituting: F = \(String(format: "%.1f", m)) × \(String(format: "%.1f", a)) = \(String(format: "%.2f", correctAnswer)) N",
                givenValues: ["m": m, "a": a]
            )
        default:
            let r = Double.random(in: 1...10)
            let correctAnswer = Double.pi * r * r
            return Exercise(
                formulaId: formula.id,
                question: "Calculate the area of a circle with radius \(String(format: "%.1f", r)) m.",
                correctAnswer: correctAnswer,
                explanation: "We use the formula S = π × r². Substituting: S = π × \(String(format: "%.1f", r))² = \(String(format: "%.2f", correctAnswer)) m²",
                givenValues: ["r": r]
            )
        }
    }
}

