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
    @State private var showAddSheet = false

    private let labTitle = "My Lab" // TODO: Bind to user display name for "[User]'s Lab"
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
                    EmptyView().navButton(icon: "dice.fill") {
                        // Random action
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
                        // Saved experiments: simple list of titles for verification
                        ForEach(experiments) { experiment in
                            Text(experiment.title)
                                .font(.appBodySmall)
                                .foregroundStyle(Color.appFont)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.appSecondary, lineWidth: 1)
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
        }
    }
}


#Preview {
    LabView()
}
