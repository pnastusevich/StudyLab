import SwiftUI

@main
struct StudyLabApp: App {
    @StateObject private var progressManager = ProgressManager()
    @StateObject private var progressViewModel: ProgressViewModel
    private let logger = LoggerService()
    
    init() {
        let tempProgressManager = ProgressManager()
        let viewModel = ProgressViewModel(progressManager: tempProgressManager)
        _progressViewModel = StateObject(wrappedValue: viewModel)
        logger.info("StudyLab app initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(progressManager)
                .environmentObject(progressViewModel)
                .preferredColorScheme(progressViewModel.isDarkMode ? .dark : .light)
                .onAppear {
                    progressViewModel.updateProgressManager(progressManager)
                }
        }
    }
}
