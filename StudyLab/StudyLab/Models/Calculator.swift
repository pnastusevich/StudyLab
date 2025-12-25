import Foundation

enum CalculatorType: String, CaseIterable, Identifiable {
    case speed = "Speed"
    case force = "Force"
    case circleArea = "Circle Area"
    case kineticEnergy = "Kinetic Energy"
    case volume = "Volume"
    case quadraticEquation = "Quadratic Equation"
    case potentialEnergy = "Potential Energy"
    case momentum = "Momentum"
    case work = "Work"
    case power = "Power"
    case density = "Density"
    case pressure = "Pressure"
    case ohmLaw = "Ohm's Law"
    case triangleArea = "Triangle Area"
    case rectanglePerimeter = "Rectangle Perimeter"
    case cylinderVolume = "Cylinder Volume"
    case sphereSurfaceArea = "Sphere Surface Area"
    case trapezoidArea = "Trapezoid Area"
    case pythagorean = "Pythagorean Theorem"
    
    var id: String { rawValue }
    
    var inputs: [InputField] {
        switch self {
        case .speed:
            return [
                InputField(name: "Distance (s)", symbol: "s", unit: "m"),
                InputField(name: "Time (t)", symbol: "t", unit: "s")
            ]
        case .force:
            return [
                InputField(name: "Mass (m)", symbol: "m", unit: "kg"),
                InputField(name: "Acceleration (a)", symbol: "a", unit: "m/s²")
            ]
        case .circleArea:
            return [
                InputField(name: "Radius (r)", symbol: "r", unit: "m")
            ]
        case .kineticEnergy:
            return [
                InputField(name: "Mass (m)", symbol: "m", unit: "kg"),
                InputField(name: "Velocity (v)", symbol: "v", unit: "m/s")
            ]
        case .volume:
            return [
                InputField(name: "Length (a)", symbol: "a", unit: "m"),
                InputField(name: "Width (b)", symbol: "b", unit: "m"),
                InputField(name: "Height (h)", symbol: "h", unit: "m")
            ]
        case .quadraticEquation:
            return [
                InputField(name: "Coefficient a", symbol: "a", unit: ""),
                InputField(name: "Coefficient b", symbol: "b", unit: ""),
                InputField(name: "Coefficient c", symbol: "c", unit: "")
            ]
        case .potentialEnergy:
            return [
                InputField(name: "Mass (m)", symbol: "m", unit: "kg"),
                InputField(name: "Height (h)", symbol: "h", unit: "m")
            ]
        case .momentum:
            return [
                InputField(name: "Mass (m)", symbol: "m", unit: "kg"),
                InputField(name: "Velocity (v)", symbol: "v", unit: "m/s")
            ]
        case .work:
            return [
                InputField(name: "Force (F)", symbol: "F", unit: "N"),
                InputField(name: "Distance (s)", symbol: "s", unit: "m")
            ]
        case .power:
            return [
                InputField(name: "Work (A)", symbol: "A", unit: "J"),
                InputField(name: "Time (t)", symbol: "t", unit: "s")
            ]
        case .density:
            return [
                InputField(name: "Mass (m)", symbol: "m", unit: "kg"),
                InputField(name: "Volume (V)", symbol: "V", unit: "m³")
            ]
        case .pressure:
            return [
                InputField(name: "Force (F)", symbol: "F", unit: "N"),
                InputField(name: "Area (S)", symbol: "S", unit: "m²")
            ]
        case .ohmLaw:
            return [
                InputField(name: "Voltage (U)", symbol: "U", unit: "V"),
                InputField(name: "Current (I)", symbol: "I", unit: "A")
            ]
        case .triangleArea:
            return [
                InputField(name: "Base (a)", symbol: "a", unit: "m"),
                InputField(name: "Height (h)", symbol: "h", unit: "m")
            ]
        case .rectanglePerimeter:
            return [
                InputField(name: "Length (a)", symbol: "a", unit: "m"),
                InputField(name: "Width (b)", symbol: "b", unit: "m")
            ]
        case .cylinderVolume:
            return [
                InputField(name: "Radius (r)", symbol: "r", unit: "m"),
                InputField(name: "Height (h)", symbol: "h", unit: "m")
            ]
        case .sphereSurfaceArea:
            return [
                InputField(name: "Radius (r)", symbol: "r", unit: "m")
            ]
        case .trapezoidArea:
            return [
                InputField(name: "Base a", symbol: "a", unit: "m"),
                InputField(name: "Base b", symbol: "b", unit: "m"),
                InputField(name: "Height (h)", symbol: "h", unit: "m")
            ]
        case .pythagorean:
            return [
                InputField(name: "Leg a", symbol: "a", unit: "m"),
                InputField(name: "Leg b", symbol: "b", unit: "m")
            ]
        }
    }
    
    var formula: String {
        switch self {
        case .speed: return "v = s / t"
        case .force: return "F = m × a"
        case .circleArea: return "S = π × r²"
        case .kineticEnergy: return "E = (m × v²) / 2"
        case .volume: return "V = a × b × h"
        case .quadraticEquation: return "ax² + bx + c = 0"
        case .potentialEnergy: return "E = m × g × h"
        case .momentum: return "p = m × v"
        case .work: return "A = F × s"
        case .power: return "P = A / t"
        case .density: return "ρ = m / V"
        case .pressure: return "p = F / S"
        case .ohmLaw: return "U = I × R"
        case .triangleArea: return "S = (a × h) / 2"
        case .rectanglePerimeter: return "P = 2 × (a + b)"
        case .cylinderVolume: return "V = π × r² × h"
        case .sphereSurfaceArea: return "S = 4 × π × r²"
        case .trapezoidArea: return "S = ((a + b) × h) / 2"
        case .pythagorean: return "a² + b² = c²"
        }
    }
    
    func calculate(values: [Double]) -> CalculatorResult {
        switch self {
        case .speed:
            guard values.count == 2, values[1] != 0 else {
                return .error("Time cannot be zero")
            }
            let result = values[0] / values[1]
            return .success(result, "m/s")
            
        case .force:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = values[0] * values[1]
            return .success(result, "N")
            
        case .circleArea:
            guard values.count == 1 else { return .error("Insufficient data") }
            let result = Double.pi * values[0] * values[0]
            return .success(result, "m²")
            
        case .kineticEnergy:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = (values[0] * values[1] * values[1]) / 2
            return .success(result, "J")
            
        case .volume:
            guard values.count == 3 else { return .error("Insufficient data") }
            let result = values[0] * values[1] * values[2]
            return .success(result, "m³")
            
        case .quadraticEquation:
            guard values.count == 3, values[0] != 0 else {
                return .error("Coefficient a cannot be zero")
            }
            let a = values[0]
            let b = values[1]
            let c = values[2]
            let discriminant = b * b - 4 * a * c
            
            if discriminant < 0 {
                return .error("Negative discriminant, no real roots")
            } else if discriminant == 0 {
                let x = -b / (2 * a)
                return .success(x, "x = \(String(format: "%.2f", x))")
            } else {
                let x1 = (-b + sqrt(discriminant)) / (2 * a)
                let x2 = (-b - sqrt(discriminant)) / (2 * a)
                return .success(x1, "x₁ = \(String(format: "%.2f", x1)), x₂ = \(String(format: "%.2f", x2))")
            }
        case .potentialEnergy:
            guard values.count == 2 else { return .error("Insufficient data") }
            let g = 9.8
            let result = values[0] * g * values[1]
            return .success(result, "J")
        case .momentum:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = values[0] * values[1]
            return .success(result, "kg·m/s")
        case .work:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = values[0] * values[1]
            return .success(result, "J")
        case .power:
            guard values.count == 2, values[1] != 0 else {
                return .error("Time cannot be zero")
            }
            let result = values[0] / values[1]
            return .success(result, "W")
        case .density:
            guard values.count == 2, values[1] != 0 else {
                return .error("Volume cannot be zero")
            }
            let result = values[0] / values[1]
            return .success(result, "kg/m³")
        case .pressure:
            guard values.count == 2, values[1] != 0 else {
                return .error("Area cannot be zero")
            }
            let result = values[0] / values[1]
            return .success(result, "Pa")
        case .ohmLaw:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = values[0] / values[1]
            return .success(result, "Ω")
        case .triangleArea:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = (values[0] * values[1]) / 2
            return .success(result, "m²")
        case .rectanglePerimeter:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = 2 * (values[0] + values[1])
            return .success(result, "m")
        case .cylinderVolume:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = Double.pi * values[0] * values[0] * values[1]
            return .success(result, "m³")
        case .sphereSurfaceArea:
            guard values.count == 1 else { return .error("Insufficient data") }
            let result = 4 * Double.pi * values[0] * values[0]
            return .success(result, "m²")
        case .trapezoidArea:
            guard values.count == 3 else { return .error("Insufficient data") }
            let result = ((values[0] + values[1]) * values[2]) / 2
            return .success(result, "m²")
        case .pythagorean:
            guard values.count == 2 else { return .error("Insufficient data") }
            let result = sqrt(values[0] * values[0] + values[1] * values[1])
            return .success(result, "m")
        }
    }
}

struct InputField: Identifiable {
    let id: UUID
    let name: String
    let symbol: String
    let unit: String
    
    init(id: UUID = UUID(), name: String, symbol: String, unit: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.unit = unit
    }
}

enum CalculatorResult {
    case success(Double, String)
    case error(String)
}

