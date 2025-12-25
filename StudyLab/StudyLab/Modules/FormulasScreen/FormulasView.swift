import SwiftUI

struct FormulasView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var progressManager: ProgressManager
    @StateObject private var viewModel: FormulasViewModel
    private let logger = LoggerService()
    
    init() {
        _viewModel = StateObject(wrappedValue: FormulasViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Picker("Subject", selection: $viewModel.selectedSubject) {
                        ForEach(Subject.allCases) { subject in
                            Text(subject.rawValue).tag(subject)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .padding(.top, 60)
                    .onChange(of: viewModel.selectedSubject) { newSubject in
                        logger.info("Subject selected: \(newSubject.rawValue)")
                    }
                    
                    List(viewModel.filteredFormulas) { formula in
                        NavigationLink(value: NavigationDestination.formulaDetail(formula)) {
                            FormulaRowView(formula: formula)
                        }
                    }
                    .listStyle(.plain)
                }
                
                CustomNavigationBar(title: "Formulas")
            }
            .navigationBarHidden(true)
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .formulaDetail(let formula):
                    FormulaDetailView(formula: formula)
                        .environmentObject(viewModel)
                        .environmentObject(coordinator)
                        .environmentObject(progressManager)
                case .exercise(let exercise):
                    ExerciseView(exercise: exercise)
                        .environmentObject(coordinator)
                        .environmentObject(progressManager)
                }
            }
            .onAppear {
                viewModel.updateProgressManager(progressManager)
            }
        }
    }
}

struct FormulaRowView: View {
    let formula: Formula
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formula.name)
                .font(.headline)
            
            Text(formula.formula)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.secondary)
            
            Text(formula.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}
