//
//  LabView.swift
//  SSC_Lab
//
//  Created by yumii on 11/02/2026.
//

import SwiftUI

struct LabView: View {
    private let labTitle = "My Lab" // TODO: Bind to user display name for "[User]'s Lab"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(labTitle)
                    .font(.appHero)
                    .foregroundStyle(Color.appFont)
                    .padding(.horizontal, 16)

                Spacer()
                    .frame(height: 16)

                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        // TODO: I'LL ADD THE REST OF THE MOCK DATA LATER - THE FUN PART!
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
                    .padding(.horizontal, 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 12) {
                        Button {
                            // Random action
                        } label: {
                            Image(systemName: "dice.fill")
                                .frame(width: 44, height: 44)
                                .background(Circle().stroke(Color.appSecondary, lineWidth: 1.5))
                        }
                        Button {
                            // Add action
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 44, height: 44)
                                .background(Circle().stroke(Color.appSecondary, lineWidth: 1.5))
                        }
                    }
                }
            }
        }
        
    }
}


#Preview {
    LabView()
}
