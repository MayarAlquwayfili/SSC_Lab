//
//  LabView.swift
//  SSC_Lab
//
//  Created by yumii on 11/02/2026.
//

import SwiftUI
import SwiftData

struct LabView: View {
    @Query private var experiments: [Experiment]
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = LabViewModel()
    @State private var showAddSheet = false
    @State private var selectedExperiment: Experiment?

    private let labTitle = "My Lab"
    private let horizontalMargin: CGFloat = 16
    private let gridSpacing: CGFloat = 16

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                AppHeader(title: labTitle) {
                    HStack(spacing: 0) {
                        EmptyView().navButton(icon: "dice.fill") {
                            if let random = viewModel.randomize(from: experiments) {
                                selectedExperiment = random
                            }
                        }
                        EmptyView().navButton(icon: "plus") { showAddSheet = true }
                    }
                }

                Spacer()
                    .frame(height: 16)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: gridSpacing),
                        GridItem(.flexible(), spacing: gridSpacing)
                    ], spacing: gridSpacing) {
                        ForEach(experiments) { experiment in
                            Button {
                                selectedExperiment = experiment
                            } label: {
                                ExperimentCard(
                                    title: experiment.title,
                                    topBadges: [topBadge(for: experiment.environment)],
                                    bottomBadges: bottomBadges(for: experiment)
                                )
                            }
                            .buttonStyle(.plain)
                            .contextMenu {
                                Button {
                                    viewModel.toggleActive(experiment: experiment, allExperiments: experiments, context: modelContext)
                                } label: {
                                    Label(experiment.isActive ? "Deactivate" : "Set Active", systemImage: "bolt.fill")
                                }
                                Button(role: .destructive) {
                                    viewModel.delete(experiment: experiment, context: modelContext)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        if experiments.isEmpty {
                            ExperimentCard(
                                title: "COLOR SPRAY",
                                topBadges: [.indoor],
                                bottomBadges: [.indoor, .tools, .timeframe("1D")]
                            )
                            .gridCellColumns(2)
                        }
                    }
                    .padding(.horizontal, horizontalMargin)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedExperiment) { experiment in
                ExperimentDetailView(experiment: experiment)
                    .onDisappear { selectedExperiment = nil }
            }
            .sheet(isPresented: $showAddSheet) {
                AddNewExperimentView()
            }
            .onAppear {
                if experiments.isEmpty {
                    let exp1 = Experiment(
                        title: "COLOR SPRAY",
                        icon: "paintpalette.fill",
                        environment: "indoor",
                        tools: "required",
                        timeframe: "1D",
                        referenceURL: "",
                        labNotes: "Testing techniques."
                    )
                    modelContext.insert(exp1)

                    let exp2 = Experiment(
                        title: "POTTERY",
                        icon: "hands.and.sparkles.fill",
                        environment: "indoor",
                        tools: "required",
                        timeframe: "7D",
                        referenceURL: "",
                        labNotes: "Glazing process."
                    )
                    modelContext.insert(exp2)

                    let exp3 = Experiment(
                        title: "SWIFT CHALLENGE",
                        icon: "swift",
                        environment: "indoor",
                        tools: "none",
                        timeframe: "1D",
                        referenceURL: "",
                        labNotes: "Logic practice."
                    )
                    modelContext.insert(exp3)

                    let exp4 = Experiment(
                        title: "SHOP",
                        icon: "cart.fill",
                        environment: "outdoor",
                        tools: "required",
                        timeframe: "14D",
                        referenceURL: "",
                        labNotes: "Layout planning."
                    )
                    modelContext.insert(exp4)
                    
                    try? modelContext.save()
                }
            }
        }
    }

    private func topBadge(for environment: String) -> BadgeType {
        environment.lowercased() == "outdoor" ? .outdoor : .indoor
    }

    private func bottomBadges(for experiment: Experiment) -> [BadgeType] {
        var badges: [BadgeType] = []
        badges.append(topBadge(for: experiment.environment))
        badges.append(experiment.tools.lowercased() == "none" ? .noTools : .tools)
        badges.append(.timeframe(experiment.timeframe))
        if let log = experiment.logType, log == "newInterest" {
            badges.append(.newInterest)
        } else if experiment.logType != nil {
            badges.append(.oneTime)
        }
        return badges
    }
}


#Preview {
    LabView()
}
