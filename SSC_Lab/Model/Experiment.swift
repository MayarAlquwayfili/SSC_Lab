//
//  Experiment.swift
//  SSC_Lab
//
//  SwiftData model for a lab experiment. Conforms to Identifiable via @Model.
//

import Foundation
import SwiftData

@Model
final class Experiment {
    var title: String
    var icon: String
    var environment: String  // EnvironmentOption.rawValue
    var tools: String         // ToolsOption.rawValue
    var timeframe: String     // e.g. "1D", "7D", "30D", "+30D"
    var logType: String?      // LogTypeOption.rawValue, optional
    var referenceURL: String
    var labNotes: String

    init(
        title: String,
        icon: String = "star.fill",
        environment: String = "indoor",
        tools: String = "required",
        timeframe: String = "1D",
        logType: String? = nil,
        referenceURL: String = "",
        labNotes: String = ""
    ) {
        self.title = title
        self.icon = icon
        self.environment = environment
        self.tools = tools
        self.timeframe = timeframe
        self.logType = logType
        self.referenceURL = referenceURL
        self.labNotes = labNotes
    }
}
