import Combine
import SwiftUI

final class ProgressViewModel: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "StudyLabDarkMode")
            logger.info("Theme changed to: \(isDarkMode ? "dark" : "light")")
        }
    }
    
    var progressManager: ProgressManager?
    private let logger = LoggerService()
    
    var progressState: ProgressState {
        progressManager?.progressState ?? ProgressState()
    }
    
    init(progressManager: ProgressManager? = nil) {
        self.progressManager = progressManager
        self.isDarkMode = UserDefaults.standard.bool(forKey: "StudyLabDarkMode")
        logger.info("ProgressViewModel initialized. Dark mode: \(isDarkMode)")
    }
    
    func updateProgressManager(_ manager: ProgressManager) {
        self.progressManager = manager
    }
    
    func resetProgress() {
        logger.warning("Reset progress requested from ProgressViewModel")
        progressManager?.resetProgress()
    }
}

