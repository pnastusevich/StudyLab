import SwiftUI

struct SlideInSettingsView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: ProgressViewModel
    private let logger = LoggerService()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .trailing) {
                Color.black.opacity(isPresented ? 0.3 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        logger.info("Settings view dismissed by tap outside")
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                            isPresented = false
                        }
                    }
                    .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isPresented)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            logger.info("Settings view dismissed by close button")
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isPresented = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    
                    List {
                        Section("Appearance") {
                            Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                        }
                        
                        Section("Data") {
                            Button(role: .destructive) {
                                viewModel.resetProgress()
                            } label: {
                                HStack {
                                    Image(systemName: "trash.fill")
                                    Text("Reset Statistics")
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                .frame(width: geometry.size.width * 0.9)
                .background(Color(.systemBackground))
                .offset(x: isPresented ? 0 : geometry.size.width)
                .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isPresented)
            }
        }
    }
}

