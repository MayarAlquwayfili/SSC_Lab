//
//  View+Extensions.swift
//  SSC_Lab
//
//  Created by yumii on 13/02/2026.
//

import SwiftUI
import UIKit

// MARK: - Nav toolbar button (40×40 circle, subtle background, 14–16pt icon)
extension View {
    func navButton(icon: String, color: Color = .appFont, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.appFont.opacity(0.05)))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Discard changes alert (reusable)
extension View {
    func discardAlert(isPresented: Binding<Bool>, onDiscard: @escaping () -> Void) -> some View {
        alert("Unsaved Changes", isPresented: isPresented) {
            Button("Keep Editing", role: .cancel) {}
            Button("Discard", role: .destructive, action: onDiscard)
        } message: {
            Text("Are you sure you want to discard your changes? This action cannot be undone.")
        }
    }
}

// MARK: - Custom popup overlay (AppPopUp with dim + scale spring)
extension View {
    func showPopUp(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        primaryStyle: AppButtonStyle = .primary,
        onPrimary: @escaping () -> Void,
        onSecondary: @escaping () -> Void = {}
    ) -> some View {
        overlay {
            if isPresented.wrappedValue {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    AppPopUp(
                        title: title,
                        message: message,
                        primaryButtonTitle: primaryButtonTitle,
                        secondaryButtonTitle: secondaryButtonTitle,
                        primaryStyle: primaryStyle,
                        onPrimary: onPrimary,
                        onSecondary: {
                            isPresented.wrappedValue = false
                            onSecondary()
                        }
                    )
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isPresented.wrappedValue)
    }
}

// MARK: - Section header (30pt top, 7pt bottom, 1px divider)
extension View {
    func sectionHeader(
        title: String,
        topSpacing: CGFloat = 30,
        bottomSpacing: CGFloat = 7,
        horizontalPadding: CGFloat = 16
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.appSubHeadline)
                .foregroundStyle(Color.appFont)
            Divider()
                .background(Color.appFont)
                .frame(height: 1)
        }
        .padding(.top, topSpacing)
        .padding(.bottom, bottomSpacing)
        .padding(.horizontal, horizontalPadding)
    }
}

// MARK: - Experiment setup icon (asset or SF Symbol)
extension View {
    @ViewBuilder
    func experimentSetupIcon(iconName: String, size: CGFloat = 16) -> some View {
        if UIImage(named: iconName) != nil {
            Image(iconName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            Image(systemName: iconName)
                .font(.system(size: size, weight: .medium))
        }
    }
}

// Experiment setup row (label + picker)
extension View {

    func experimentSetupRow<Content: View>(
        label: String,
        pickerWidth: CGFloat = 240,
        rowHeight: CGFloat = 52,
        @ViewBuilder content: () -> Content
    ) -> some View where Content: View {
        HStack(alignment: .center, spacing: 4) {
            Text(label)
                .font(.appBodySmall)
                .foregroundStyle(Color.appFont)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .fixedSize(horizontal: true, vertical: false)
                .layoutPriority(1)
            Spacer(minLength: 8)
            content()
                .frame(width: pickerWidth)
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}
