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
    @State private var showAddSheet = false

    // TODO: Bind to user display name for "[User]'s Lab"
    private let labTitle = "My Lab"
    private let horizontalMargin: CGFloat = 16

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                // Custom solid header (no liquid/glass toolbar)
                HStack(alignment: .center, spacing: 0) {
                    Text(labTitle)
                        .font(.appHero)
                        .foregroundStyle(Color.appFont)
                    Spacer(minLength: 0)
                    // TODO: Manual Test Insertion — uncomment below to insert a test experiment when tapping Dice.
                    EmptyView().navButton(icon: "dice.fill") {
                        /*
                        let testExp = Experiment(
                            title: "Test Experiment",
                            icon: "flask.fill",
                            environment: "indoor",
                            tools: "required",
                            referenceURL: "https://google.com",
                            labNotes: "Notes go here...",
                            timeframe: "1D"
                        )
                        modelContext.insert(testExp)
                        */
                    }
                    EmptyView().navButton(icon: "plus") {
                        showAddSheet = true
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, horizontalMargin)
                .background(Color.appBg)

                Spacer()
                    .frame(height: 16)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(experiments) { experiment in
                            ExperimentCard(
                                title: experiment.title,
                                topBadges: [topBadge(for: experiment.environment)],
                                bottomBadges: bottomBadges(for: experiment)
                            )
                        }
                        
                        
                        // Placeholder card when empty (keep existing design)
                        if experiments.isEmpty {
                            HStack {
                                Spacer(minLength: 0)
                                ExperimentCard(
                                    title: "COLOR SPRAY",
                                    topBadges: [.indoor],
                                    bottomBadges: [.indoor, .tools, .timeframe("1D")]
                                )
                                Spacer(minLength: 0)
                                
                                
                            }
                            .gridCellColumns(2)
                        }
                    }
                    .padding(.horizontal, horizontalMargin)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddSheet) {
                AddNewExperimentView()
            }
            .onAppear {
                if experiments.isEmpty {
                    // 1. Fixed Example (Color Spray) — order: title, icon, environment, tools, referenceURL, labNotes, timeframe
                    let colorSpray = Experiment(
                        title: "COLOR SPRAY",
                        icon: "sun.fill",
                        environment: "indoor",
                        tools: "required",
                        timeframe: "1D",
                        referenceURL: "",
                        labNotes: "Testing pigment density for the final lab result."
                    )
                    modelContext.insert(colorSpray)

                    // ---------------------------------------------------------
                    // 🚀 TODO: COPY FROM HERE TO ADD A NEW REAL EXPERIMENT
                    // ---------------------------------------------------------
                    /*
                    let exp1 = Experiment(
                        title: "Your Competition Title",
                        icon: "flask.fill",
                        environment: "indoor",
                        tools: "required",
                        timeframe: "1D",
                        referenceURL: "",
                        labNotes: "Enter your actual notes here for the judges."
                    )
                    modelContext.insert(exp1)
                    */
                    // ---------------------------------------------------------
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

