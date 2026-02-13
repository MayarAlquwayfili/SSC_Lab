//
//  MainTabView.swift
//  SSC_Lab
//
//  Created by yumii on 11/02/2026.
//

import SwiftUI
import SwiftData

enum Tab: Int, CaseIterable {
    case home = 0
    case lab
    case wins
    case settings

    var label: String {
        switch self {
        case .home: return Constants.AppTabBar.homeLabel
        case .lab: return Constants.AppTabBar.labLabel
        case .wins: return Constants.AppTabBar.winsLabel
        case .settings: return Constants.AppTabBar.settingsLabel
        }
    }

    var icon: String {
        switch self {
        case .home: return Constants.AppTabBar.homeIcon
        case .lab: return Constants.AppTabBar.labIcon
        case .wins: return Constants.AppTabBar.winsIcon
        case .settings: return Constants.AppTabBar.settingsIcon
        }
    }
}

struct MainTabView: View {
    @Namespace private var animation
    @State private var selectedTab: Tab = .lab

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home: HomePlaceholderView()
                case .lab: LabView()
                case .wins: WinsView()
                case .settings: SettingsPlaceholderView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            customTabBar
        }
        .ignoresSafeArea(.keyboard)
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                tabButton(tab)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.appShade01)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }

    private func tabButton(_ tab: Tab) -> some View {
        let isSelected = selectedTab == tab
        return Button {
            withAnimation(.snappy(duration: 0.3)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22, weight: .medium))
                Text(tab.label)
                    .font(.appMicro)
            }
            .foregroundStyle(isSelected ? Color.appFont : Color.appSecondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(Color.appShade02)
                            .matchedGeometryEffect(id: "TabPill", in: animation)
                    }
                }
            )
        }
        .buttonStyle(.plain)
    }
}

// Views (replace with real views later)
private struct HomePlaceholderView: View {
    var body: some View {
        Text("Home")
            .font(.appTitle)
            .foregroundStyle(Color.appFont)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
    }
}

private struct SettingsPlaceholderView: View {
    var body: some View {
        Text("Settings")
            .font(.appTitle)
            .foregroundStyle(Color.appFont)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg)
    }
}

#Preview {
    MainTabView()
}
