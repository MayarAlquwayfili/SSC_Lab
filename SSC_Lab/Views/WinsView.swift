//
//  WinsView.swift
//  SSC_Lab
//
//  WINS ARCHIVE: display-only grid of Win cards from SwiftData. Lab-style header, no buttons.
//

import SwiftUI
import SwiftData

struct WinsView: View {
    @Query private var wins: [Win]
    @Environment(\.modelContext) private var modelContext

    private let horizontalMargin: CGFloat = 16

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                // Custom header (Lab style): title only, no '+' or Dice
                HStack(alignment: .center, spacing: 0) {
                    Text("WINS ARCHIVE")
                        .font(.appHero)
                        .foregroundStyle(Color.appFont)
                }
                .frame(height: 44)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, horizontalMargin)
                .background(Color.appBg)

                Spacer()
                    .frame(height: 16)

                ScrollView {
                    Group {
                        if wins.isEmpty {
                            // Empty state: centered message
                            VStack {
                                Spacer(minLength: 60)
                                Text("Your archive is empty. Start winning!")
                                    .font(.appBodySmall)
                                    .foregroundStyle(Color.appSecondary)
                                    .multilineTextAlignment(.center)
                                Spacer(minLength: 60)
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ], spacing: 16) {
                                ForEach(wins) { win in
                                    WinCard(win: win)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, horizontalMargin)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
            .navigationBarHidden(true)
            .onAppear {
                if wins.isEmpty {
                    // 1. Ready-made Win Example — order matches Win model: title, imageName, logTypeIcon, icon1, icon2, icon3 (date uses default)
                    let sampleWin = Win(
                        title: "FIRST EXPERIMENT WIN",
                        imageName: nil, // Change to your Asset image name later
                        logTypeIcon: "star.fill",
                        icon1: "flask.fill",
                        icon2: "bolt.fill",
                        icon3: "1D"
                    )
                    modelContext.insert(sampleWin)

                    // ---------------------------------------------------------
                    // 🏆 TODO: COPY FROM HERE TO ADD A NEW REAL WIN
                    // IMPORTANT: Use unique names like win1, win2, win3...
                    // ---------------------------------------------------------
                    /*
                    let win1 = Win(
                        title: "Your Epic Win Title",
                        imageName: nil, // Put the exact name from Assets
                        logTypeIcon: "star.fill",
                        icon1: "icon_name",
                        icon2: "icon_name",
                        icon3: "icon_name"
                    )
                    modelContext.insert(win1)
                    */
                    // ---------------------------------------------------------
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Win.self, configurations: config)
    return WinsView()
        .modelContainer(container)
}
