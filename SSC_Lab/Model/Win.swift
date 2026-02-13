//
//  Win.swift
//  SSC_Lab
//
//  SwiftData model for a logged win. Conforms to Identifiable via @Model.
//

import Foundation
import SwiftData

@Model
final class Win {
    var title: String
    var imageName: String?
    var logTypeIcon: String   // 4th icon on WinCard (e.g. oneTime, newInterest)
    var date: Date
    /// Optional icon names (SF Symbol or asset) for the first 3 badges on the card.
    var icon1: String?
    var icon2: String?
    var icon3: String?

    init(
        title: String,
        imageName: String? = nil,
        logTypeIcon: String,
        date: Date = .now,
        icon1: String? = nil,
        icon2: String? = nil,
        icon3: String? = nil
    ) {
        self.title = title
        self.imageName = imageName
        self.logTypeIcon = logTypeIcon
        self.date = date
        self.icon1 = icon1
        self.icon2 = icon2
        self.icon3 = icon3
    }
}
