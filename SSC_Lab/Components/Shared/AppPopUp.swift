//
//  AppPopUp.swift
//  SSC_Lab
//
//  Reusable modal popup: dimmed overlay + white card with title, message, two buttons.
//

import SwiftUI

struct AppPopUp: View {
    var title: String
    var message: String
    var primaryButtonTitle: String
    var secondaryButtonTitle: String
    var primaryStyle: AppButtonStyle = .primary
    var onPrimary: () -> Void
    var onSecondary: () -> Void

    private let cardPadding: CGFloat = 24
    private let cornerRadius: CGFloat = 26

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.appHero)
                .foregroundStyle(Color.appFont)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            Text(message)
                .font(.appBodySmall)
                .foregroundStyle(Color.appSecondaryDark)
                .multilineTextAlignment(.center)
                .padding(.top, 12)
                .frame(maxWidth: .infinity)

            HStack(spacing: 12) {
                AppButton(title: secondaryButtonTitle, style: .secondary, action: onSecondary)
                AppButton(title: primaryButtonTitle, style: primaryStyle, action: onPrimary)
            }
            .padding(.top, 24)
        }
        .padding(cardPadding)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
        )
        .padding(.horizontal, 32)
    }
}

#Preview("AppPopUp") {
    ZStack {
        Color.appBg.ignoresSafeArea()
        Color.black.opacity(0.4)
            .ignoresSafeArea()
        AppPopUp(
            title: "Discard Changes?",
            message: "Are you sure you want to leave without saving?",
            primaryButtonTitle: "Discard",
            secondaryButtonTitle: "Keep Editing",
            primaryStyle: .destructive,
            onPrimary: {},
            onSecondary: {}
        )
    }
}
