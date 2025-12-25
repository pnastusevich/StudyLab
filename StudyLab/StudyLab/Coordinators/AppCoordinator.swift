import SwiftUI
import Combine

enum NavigationDestination: Hashable {
    case formulaDetail(Formula)
    case exercise(Exercise)
}

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigateToExercise(_ exercise: Exercise) {
        path.append(NavigationDestination.exercise(exercise))
    }
    
    func navigateBack() {
        path.removeLast()
    }
}

