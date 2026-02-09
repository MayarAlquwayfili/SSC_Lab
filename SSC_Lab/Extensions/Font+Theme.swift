//
//  Font+Theme.swift
//  SSC_Lab
//
//  Created by yumii on 09/02/2026.
//

import Foundation
import SwiftUI

extension Font {
    
    // Custom Fonts
    
    /// Bobby Jones Soft (36)
    static var appHero: Font {
        .custom("Bobby Jones Soft", size: 36, relativeTo: .largeTitle)
    }
    /// Magic World Line (36)
    static var appWin: Font {
        .custom("magic-world.line", size: 36, relativeTo: .largeTitle)
    }
    /// Magic World  (36)
    static var appCard: Font {
        .custom("magic-world.regular", size: 36, relativeTo: .title)
    }
    
    
    // System Fonts
    
    /// SF Pro Medium (20)
    static var appTitle: Font {
        .system(size: 20, weight: .medium, design: .rounded)
    }
    /// SF Pro Semibold (17)
    static var appSubHeadline: Font {
        .system(size: 17, weight: .semibold, design: .rounded)
    }
    /// SF Pro Medium (17)
    static var appBody: Font {
        .system(size: 17, weight: .medium, design: .rounded)
    }
    /// SF Pro Regular (15)
    static var appBodySmall: Font {
        .system(size: 15, weight: .regular, design: .rounded)
    }
    /// SF Pro Italic (12)
    static var appCaption: Font {
        .system(size: 12, weight: .regular, design: .rounded).italic()
    }
    /// SF Pro Regular (10)
    static var appMicro: Font {
        .system(size: 10, weight: .regular, design: .rounded)
    }
}
