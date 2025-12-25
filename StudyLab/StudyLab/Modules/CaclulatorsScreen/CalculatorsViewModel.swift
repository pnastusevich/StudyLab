import SwiftUI
import Combine

final class CalculatorsViewModel: ObservableObject {
    @Published var selectedCalculator: CalculatorType = .speed {
        didSet {
            initializeInputs()
            clearResult()
        }
    }
    @Published var result: CalculatorResult?
    @Published var inputTexts: [UUID: String] = [:]
    @Published var currentInputs: [InputField] = []
    
    var progressManager: ProgressManager?
    private let logger = LoggerService()
    
    init(progressManager: ProgressManager? = nil) {
        self.progressManager = progressManager
        initializeInputs()
    }
    
    func updateProgressManager(_ manager: ProgressManager) {
        self.progressManager = manager
    }
    
    func clearResult() {
        result = nil
    }
    
    func initializeInputs() {
        currentInputs = selectedCalculator.inputs
        inputTexts = [:]
        for input in currentInputs {
            inputTexts[input.id] = ""
        }
    }
    
    func calculate() {
        logger.info("Calculating with calculator: \(selectedCalculator.rawValue)")
        var values: [Double] = []
        
        for input in currentInputs {
            guard let valueString = inputTexts[input.id],
                  !valueString.isEmpty,
                  let value = Double(valueString.replacingOccurrences(of: ",", with: ".")) else {
                logger.warning("Calculation failed: empty fields")
                result = .error("Fill in all fields")
                return
            }
            values.append(value)
        }
        
        result = selectedCalculator.calculate(values: values)
        
        switch result {
        case .success(let value, let unit):
            logger.info("Calculation successful: result = \(value) \(unit)")
            progressManager?.incrementCalculations()
        case .error(let error):
            logger.error("Calculation error: \(error)")
        case .none:
            break
        }
    }
}

