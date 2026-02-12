//
//  ExperimentCard.swift
//  SSC_Lab
//
//  Created by yumii on 11/02/2026.
//

import SwiftUI

struct ExperimentCard: View {
    var title: String
    var topBadges: [BadgeType]
    var bottomBadges: [BadgeType]
    var size: BadgeSize = .small
    var variant: BadgeVariant = .primary
 
    private let cardSize: CGFloat = 181
    private let cornerRadius: CGFloat = 16

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.appSecondary, lineWidth: 1.5)

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer(minLength: 0)
                    if let topIcon = topBadges.first {
                        StatusBadge(type: topIcon, size: size, variant: variant)
                            .padding(.top, 8)
                            .padding(.trailing, 8)
                    }
                }

                Spacer(minLength: 0)

                Text(title)
                    .font(.appCard)
                    .foregroundStyle(Color.appPrimary)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
 
                Spacer(minLength: 0)

                StatusGroup(items: bottomBadges, size: size, variant: variant)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
             }
        }
        .frame(width: cardSize, height: cardSize)
    }
}

// MARK: - Previews
#Preview("ExperimentCard – Lab mode (3 badges)") {
    ExperimentCard(
        title: "Hi",
        topBadges: [.indoor],
        bottomBadges: [.indoor, .tools, .timeframe("1D")],
        size: .small,
        variant: .primary
    )
    .padding()
    .background(Color.appBg)
}

#Preview("ExperimentCard – Wins mode (4 badges)") {
    ExperimentCard(
        title: "Outdoor",
        topBadges: [.outdoor],
        bottomBadges: [.outdoor, .noTools, .timeframe("+30D"), .oneTime],
        size: .small,
        variant: .primary
    )
    .padding()
    .background(Color.appBg)
}
