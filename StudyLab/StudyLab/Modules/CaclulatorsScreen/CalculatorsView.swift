import SwiftUI

struct CalculatorsView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @StateObject private var viewModel: CalculatorsViewModel
    @FocusState private var focusedField: UUID?
    
    init() {
        _viewModel = StateObject(wrappedValue: CalculatorsViewModel())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomNavigationBar(title: "Calculators")
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Select Calculator")
                                .font(.headline)
                            
                            Picker("Calculator", selection: $viewModel.selectedCalculator) {
                                ForEach(CalculatorType.allCases) { calculator in
                                    Text(calculator.rawValue).tag(calculator)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: viewModel.selectedCalculator) { _ in
                                focusedField = nil
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Formula")
                                .font(.headline)
                            Text(viewModel.selectedCalculator.formula)
                                .font(.system(.title3, design: .monospaced))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemBackground))
                                .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Enter Values")
                                .font(.headline)
                            
                            ForEach(viewModel.currentInputs) { input in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(input.name)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    TextField(input.unit, text: Binding(
                                        get: {
                                            viewModel.inputTexts[input.id] ?? ""
                                        },
                                        set: { newValue in
                                            viewModel.inputTexts[input.id] = newValue
                                        }
                                    ))
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)
                                    .focused($focusedField, equals: input.id)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                        Button(action: {
                            focusedField = nil
                            viewModel.calculate()
                        }) {
                            HStack {
                                Image(systemName: "equal.circle.fill")
                                Text("Calculate")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        
                        if let result = viewModel.result {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Result")
                                    .font(.headline)
                                
                                switch result {
                                case .success(let value, let unit):
                                    HStack {
                                        Text(String(format: "%.2f", value))
                                            .font(.system(.title, design: .monospaced))
                                        Text(unit)
                                            .font(.title3)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(8)
                                    
                                case .error(let message):
                                    Text(message)
                                        .foregroundColor(.red)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.red.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            focusedField = nil
                        }
                )
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.updateProgressManager(progressManager)
            }
        }
    }
}
