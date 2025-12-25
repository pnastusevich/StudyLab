import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @State private var showSettings = false
    private let logger = LoggerService()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack(alignment: .top) {
                    ScrollView {
                        VStack(spacing: 24) {
                            Spacer()
                                .frame(height: 20)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Statistics")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                StatisticRow(
                                    icon: "book.fill",
                                    title: "Formulas Viewed",
                                    value: "\(progressViewModel.progressState.viewedFormulasCount)"
                                )
                                
                                StatisticRow(
                                    icon: "divide.circle",
                                    title: "Calculations Performed",
                                    value: "\(progressViewModel.progressState.calculationsCount)"
                                )
                                
                                StatisticRow(
                                    icon: "checkmark.circle.fill",
                                    title: "Exercises Solved",
                                    value: "\(progressViewModel.progressState.solvedExercisesCount)"
                                )
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Achievements")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                let allAchievements = progressViewModel.progressState.getAllAchievements()
                                if allAchievements.isEmpty {
                                    Text("No achievements yet")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                } else {
                                    ForEach(allAchievements) { achievement in
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack {
                                                Image(systemName: achievement.isEarned ? "star.fill" : "star")
                                                    .foregroundColor(achievement.isEarned ? .yellow : .gray)
                                                Text(achievement.name)
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(achievement.isEarned ? .primary : .secondary)
                                            }
                                            Text(achievement.description)
                                                .font(.caption)
                                                .foregroundColor(achievement.isEarned ? .secondary : .gray)
                                                .padding(.leading, 24)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .padding()
                    }
                    .offset(x: showSettings ? -geometry.size.width * 0.8 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.85), value: showSettings)
                    
                    CustomNavigationBar(
                        title: "Progress",
                        trailingButton: {
                            AnyView(
                            Button(action: {
                                logger.info("Settings button tapped")
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                    showSettings = true
                                }
                            }) {
                                    Image(systemName: "gearshape.fill")
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                }
                            )
                        }
                    )
                    .offset(x: showSettings ? -geometry.size.width * 0.8 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.85), value: showSettings)
                }
                .navigationBarHidden(true)
                .overlay {
                    if showSettings {
                        SlideInSettingsView(isPresented: $showSettings)
                            .zIndex(1000)
                            .onChange(of: showSettings) { newValue in
                                if newValue {
                                    logger.info("Settings view opened")
                                } else {
                                    logger.info("Settings view closed")
                                }
                            }
                    }
                }
            }
        }
    }
}

struct StatisticRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.accentColor)
                .frame(width: 24)
            Text(title)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}
