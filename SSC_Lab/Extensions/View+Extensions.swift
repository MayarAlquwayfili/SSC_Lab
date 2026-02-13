//
//  View+Extensions.swift
//  SSC_Lab
//
//  Created by yumii on 13/02/2026.
//

import SwiftUI
import UIKit

//Experiment setup icon (asset or SF Symbol)
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
