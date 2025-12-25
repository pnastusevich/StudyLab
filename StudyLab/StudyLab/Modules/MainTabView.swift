import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        TabView {
            FormulasView()
                .environmentObject(progressManager)
                .environmentObject(coordinator)
                .tabItem {
                    Label("Formulas", systemImage: "book.fill")
                }
            
            CalculatorsView()
                .environmentObject(progressManager)
                .tabItem {
                    Label("Calculators", systemImage: "multiply.square.fill")
                }
            
            ProgressView()
                .environmentObject(progressManager)
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
        }
    }
}
