//
//  AddNewExperimentView.swift
//  SSC_Lab
//
//  Created by yumii on 13/02/2026.
//

import SwiftUI
import SwiftData

struct AddNewExperimentView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var experimentTitle: String = ""
    @State private var selectedIcon: String = "star.fill"
    @State private var referenceURL: String = ""
    @State private var labNotes: String = ""
    @State private var showDiscardAlert: Bool = false
    @State private var showIconPicker: Bool = false

    private var hasChanges: Bool {
        !experimentTitle.isEmpty || !referenceURL.isEmpty || !labNotes.isEmpty
    }

    private let horizontalMargin: CGFloat = 16

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                AppHeader(
                    title: "Add New Experiments",
                    onBack: { if hasChanges { showDiscardAlert = true } else { dismiss() } },
                    onClose: { if hasChanges { showDiscardAlert = true } else { dismiss() } }
                )

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        // Section 1: Experiments
                        EmptyView().sectionHeader(title: "Experiments", topSpacing: 10, horizontalPadding: horizontalMargin)
                        AppExperimentInputCard(title: $experimentTitle, icon: $selectedIcon, onIconTap: { showIconPicker = true })
                            .padding(.horizontal, horizontalMargin)

                        // Section 2: Setup
                        EmptyView().sectionHeader(title: "Setup", horizontalPadding: horizontalMargin)
                        ExperimentSetupCard(showLogType: false)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, horizontalMargin)

                        // Section 3: Reference
                        EmptyView().sectionHeader(title: "Reference", horizontalPadding: horizontalMargin)
                        referenceField
                            .padding(.horizontal, horizontalMargin)

                        AppNoteEditor(text: $labNotes, placeholder: "Add a note...")
                            .padding(.top, 30)
                            .padding(.horizontal, horizontalMargin)

                        // Footer
                        Spacer()
                            .frame(height: 30)
                        AppButton(title: "Add To LAB", style: .primary) {
                            let experiment = Experiment(
                                title: experimentTitle,
                                icon: selectedIcon,
                                referenceURL: referenceURL,
                                labNotes: labNotes
                            )
                            modelContext.insert(experiment)
                            dismiss()
                        }
                        .padding(.horizontal, horizontalMargin)
                    }
                    .padding(.bottom, 32)
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.appBg.ignoresSafeArea())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBg.ignoresSafeArea())
            .navigationBarHidden(true)
            .showPopUp(
                isPresented: $showDiscardAlert,
                title: "Discard Changes?",
                message: "Are you sure you want to leave without saving?",
                primaryButtonTitle: "Discard Changes",
                secondaryButtonTitle: "Keep Editing",
                primaryStyle: .destructive,
                onPrimary: { dismiss() }
            )
        }
    }

    // Section 3: Reference field
    private var referenceField: some View {
        TextField("URL:// Insert Reference", text: $referenceURL)
            .font(.appBodySmall)
            .foregroundStyle(Color.appFont)
            .padding(.horizontal, 16)
            .frame(height: 35)
            .background(Capsule().fill(Color.white))
            .overlay(Capsule().stroke(Color.appSecondary, lineWidth: 1))
    }

}

#Preview {
    AddNewExperimentView()
}
