//
//  LabViewModel.swift
//  SSC_Lab
//
//

import Foundation
import SwiftData

@Observable
final class LabViewModel {

    func delete(experiment: Experiment, context: ModelContext) {
        context.delete(experiment)
        try? context.save()
    }

    /// Returns a random experiment from the array, or nil if empty.
    func randomize(from experiments: [Experiment]) -> Experiment? {
        guard !experiments.isEmpty else { return nil }
        return experiments.randomElement()
    }

    /// Toggles active state: if currently active, deactivates; otherwise deactivates all others and sets this one active.
    func toggleActive(experiment: Experiment, allExperiments: [Experiment], context: ModelContext) {
        if experiment.isActive {
            experiment.isActive = false
        } else {
            for exp in allExperiments where exp.id != experiment.id {
                exp.isActive = false
            }
            experiment.isActive = true
        }
        try? context.save()
    }
}
