//
//  AppHeader.swift
//  SSC_Lab
//
//

import SwiftUI

private let headerContentHeight: CGFloat = 44
private let horizontalPadding: CGFloat = 16
private let headerButtonSize: CGFloat = 40
private let fallbackTopPadding: CGFloat = 20

struct AppHeader<Trailing: View>: View {
    let title: String
    let isSubScreen: Bool
    let onBack: (() -> Void)?
    let onClose: (() -> Void)?
    @ViewBuilder let trailing: () -> Trailing

    /// Main screen
    init(title: String, @ViewBuilder trailing: @escaping () -> Trailing) {
        self.title = title
        self.isSubScreen = false
        self.onBack = nil
        self.onClose = nil
        self.trailing = trailing
    }

    /// Sub-screen
    init(title: String, onBack: @escaping () -> Void, onClose: @escaping () -> Void) where Trailing == EmptyView {
        self.title = title
        self.isSubScreen = true
        self.onBack = onBack
        self.onClose = onClose
        self.trailing = { EmptyView() }
    }

    @State private var safeAreaTop: CGFloat = fallbackTopPadding

    var body: some View {
        ZStack(alignment: .top) {
            Color.appBg
                .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                Spacer()
                    .frame(height: safeAreaTop)
                Group {
                    if isSubScreen { subContent } else { mainContent }
                }
                .frame(height: headerContentHeight)
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: safeAreaTop + headerContentHeight)
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: SafeAreaTopKey.self, value: geo.safeAreaInsets.top)
            }
        )
        .onPreferenceChange(SafeAreaTopKey.self) { value in
            safeAreaTop = value > 0 ? value : fallbackTopPadding
        }
    }

    private var mainContent: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.appHero)
                .foregroundStyle(Color.appFont)
            Spacer(minLength: 0)
            trailing()
        }
        .padding(.horizontal, horizontalPadding)
    }

    private var subContent: some View {
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                headerButton(icon: "chevron.left", color: .appFont) {
                    onBack?()
                }
                .frame(width: headerButtonSize, height: headerButtonSize, alignment: .leading)
                Spacer(minLength: 0)
                headerButton(icon: "xmark", color: .appSecondaryDark) {
                    onClose?()
                }
                .frame(width: headerButtonSize, height: headerButtonSize, alignment: .trailing)
            }
            Text(title)
                .font(.appHeroSmall)
                .foregroundStyle(Color.appFont)
        }
        .padding(.horizontal, horizontalPadding)
    }

    private func headerButton(icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: headerButtonSize, height: headerButtonSize)
                .background(Circle().fill(Color.appFont.opacity(0.05)))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

// Safe area top

private struct SafeAreaTopKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}

// Main header

extension AppHeader where Trailing == EmptyView {
    init(title: String) {
        self.title = title
        self.isSubScreen = false
        self.onBack = nil
        self.onClose = nil
        self.trailing = { EmptyView() }
    }
}

// MARK: - Previews

#Preview("Main – title only") {
    AppHeader(title: "WINS ARCHIVE")
        .background(Color.appBg)
}

#Preview("Main – with trailing") {
    AppHeader(title: "My Lab") {
        HStack(spacing: 0) {
            Button { } label: {
                Image(systemName: "dice.fill")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appFont)
                    .frame(width: headerButtonSize, height: headerButtonSize)
                    .background(Circle().fill(Color.appFont.opacity(0.05)))
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            Button { } label: {
                Image(systemName: "plus")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appFont)
                    .frame(width: headerButtonSize, height: headerButtonSize)
                    .background(Circle().fill(Color.appFont.opacity(0.05)))
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
    .background(Color.appBg)
}

#Preview("Sub – centered title") {
    AppHeader(title: "POTTERY", onBack: { }, onClose: { })
        .background(Color.appBg)
}
