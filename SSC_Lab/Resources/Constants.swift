//
//  Constants.swift
//  SSC_Lab
//
//  Created by yumii on 09/02/2026.
//

import Foundation

enum Constants {
    
    // UI
    enum Strings {
        static let activeStatus  = "ACTIVE"
        static let quickLog      = "QUICK_LOG"
        static let spinWheel     = "SPIN_WHEEL"
    }
    
    // SF Symbols
    enum Icons {
        static let home          = "house"
        static let homeFill      = "house.fill"
        static let checkmark     = "checkmark"
        static let cancel        = "xmark"
        static let dice          = "dice"
        static let log           = "plus.app"
        // StatusBadge
        static let indoor        = "house.fill"
        static let outdoor       = "mountain.2.fill"
        static let tools         = "hammer.fill"
        static let oneTime       = "hands.and.sparkles.fill"
        static let newInterest   = "sparkle.magnifyingglass"
        static let toolsNone     = "ic_WithoutTools"
    }

    // Experiment Setup card
    enum Setup {
        static let environmentLabel = "Environment"
        static let toolsLabel       = "Tools"
        static let timeframeLabel   = "Timeframe"
        static let logTypeLabel     = "Log type"
        static let indoor           = "Indoor"
        static let outdoor          = "Outdoor"
        static let required         = "Required"
        static let none             = "None"
        static let oneTime          = "One time"
        static let newInterest      = "New Interest"
    }

    // Tab bar
    enum AppTabBar {
        static let homeIcon     = "square.grid.2x2.fill"
        static let homeLabel    = "Home"
        static let labIcon      = "viewfinder.circle.fill"
        static let labLabel     = "Lab"
        static let winsIcon     = "archivebox.fill"
        static let winsLabel    = "Wins"
        static let settingsIcon = "gearshape.fill"
        static let settingsLabel = "Settings"
    }
}
