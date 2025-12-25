import SwiftUI

struct ExerciseView: View {
    let exercise: Exercise
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var progressManager: ProgressManager
    @StateObject private var viewModel: ExerciseViewModel
    private let logger = LoggerService()
    
    init(exercise: Exercise) {
        self.exercise = exercise
        _viewModel = StateObject(wrappedValue: ExerciseViewModel(exercise: exercise))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Spacer()
                        .frame(height: 20)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Exercise")
                        .font(.headline)
                    Text(exercise.question)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Given:")
                        .font(.headline)
                    ForEach(Array(exercise.givenValues.keys.sorted()), id: \.self) { key in
                        HStack {
                            Text("\(key) =")
                                .font(.system(.body, design: .monospaced))
                            Text(String(format: "%.2f", exercise.givenValues[key] ?? 0))
                                .font(.system(.body, design: .monospaced))
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Answer")
                        .font(.headline)
                    TextField("Enter answer", text: $viewModel.userAnswer)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .disabled(viewModel.isChecked)
                }
                
                if !viewModel.isChecked {
                    Button(action: {
                        logger.info("Check answer button tapped for exercise")
                        viewModel.checkAnswer()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Check")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(viewModel.userAnswer.isEmpty)
                }
                
                if viewModel.isChecked {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: viewModel.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(viewModel.isCorrect ? .green : .red)
                            Text(viewModel.isCorrect ? "Correct!" : "Incorrect")
                                .font(.headline)
                                .foregroundColor(viewModel.isCorrect ? .green : .red)
                        }
                        
                        if viewModel.showExplanation {
                            Text("Explanation:")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(exercise.explanation)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(viewModel.isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .cornerRadius(12)
                    
                    Button(action: {
                        viewModel.reset()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("New Exercise")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                    }
                }
                }
                .padding()
            }
            
            CustomNavigationBar(
                title: "Training",
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
            logger.info("Exercise view appeared: \(exercise.question)")
            viewModel.updateProgressManager(progressManager)
        }
    }
}
