import SwiftUI

struct FormulaDetailView: View {
    let formula: Formula
    @EnvironmentObject var viewModel: FormulasViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    private let logger = LoggerService()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Spacer()
                        .frame(height: 20)
                    
                    Text(formula.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                
                Text(formula.formula)
                    .font(.system(.title, design: .monospaced))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
                Text(formula.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text("Variables")
                    .font(.headline)
                
                ForEach(formula.variables) { variable in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(variable.symbol)
                                .font(.system(.body, design: .monospaced))
                                .fontWeight(.semibold)
                            Text("— \(variable.name)")
                                .font(.body)
                        }
                        Text(variable.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                Button(action: {
                    logger.info("Exercise button tapped for formula: \(formula.name)")
                    let exercise = viewModel.generateExercise(for: formula)
                    coordinator.navigateToExercise(exercise)
                }) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                        Text("Example Exercise")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                }
                .padding()
            }
            
            CustomNavigationBar(
                title: formula.name,
                leadingButton: {
                    AnyView(
                        Button(action: {
                            coordinator.navigateBack()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    )
                }
            )
        }
        .navigationBarHidden(true)
        .onAppear {
            logger.info("Formula detail view appeared: \(formula.name)")
            viewModel.markFormulaViewed(formula)
        }
    }
}

