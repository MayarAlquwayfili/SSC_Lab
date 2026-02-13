//
//  AddNewExperimentView.swift
//  SSC_Lab
//
//  Created by yumii on 13/02/2026.
//

import SwiftUI

struct AddNewExperimentView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var experimentTitle: String = ""
    @State private var referenceURL: String = ""
    @State private var labNotes: String = ""
    @State private var labNotesHeight: CGFloat = 100
    @State private var showDiscardAlert: Bool = false

    private var hasChanges: Bool {
        !experimentTitle.isEmpty || !referenceURL.isEmpty || !labNotes.isEmpty
    }

    private let horizontalMargin: CGFloat = 16
    private let labNotesMinHeight: CGFloat = 100
    private let titleTopPadding: CGFloat = 10

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    EmptyView().navButton(icon: "chevron.left") {
                        if hasChanges { showDiscardAlert = true } else { dismiss() }
                    }
                    Spacer(minLength: 0)
                    EmptyView().navButton(icon: "xmark", color: .appSecondaryDark) {
                        if hasChanges { showDiscardAlert = true } else { dismiss() }
                    }
                }
                .frame(height: 44)
                .padding(.horizontal, 16)
                .background(Color.appBg)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Add New Experiments")
                            .font(.appHero)
                            .foregroundStyle(Color.appFont)
                            .padding(.top, titleTopPadding)
                            .padding(.horizontal, horizontalMargin)

                        // Section 1: Experiments
                        EmptyView().sectionHeader(title: "Experiments", horizontalPadding: horizontalMargin)
                        experimentsCard
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

                        // Section 4: LAB Notes
                        EmptyView().sectionHeader(title: "LAB Notes", horizontalPadding: horizontalMargin)
                        labNotesEditor
                            .padding(.horizontal, horizontalMargin)

                        // Footer
                        Spacer()
                            .frame(height: 30)
                        AppButton(title: "Add To LAB", style: .primary) {
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

    // Section 1: Experiments card
    private var experimentsCard: some View {
        VStack(spacing: 0) {
            TextField("Want to try something New?", text: $experimentTitle)
                .font(.appBodySmall)
                .foregroundStyle(Color.appFont)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 44)

            Divider()
                .background(Color.appSecondary)
                .padding(.horizontal, 16)

            HStack {
                Text("Choose Experiments Icon")
                    .font(.appBodySmall)
                    .foregroundStyle(Color.appSecondary)
                Spacer(minLength: 0)
                Button { } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.appPrimary)
                        .frame(width: 22, height: 22)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(minHeight: 44)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appSecondary, lineWidth: 1)
        )
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

    // Section 4: LAB Notes editor (dynamic height from hidden Text measurement)
    private var labNotesEditor: some View {
        ZStack(alignment: .topLeading) {
             RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.appSecondary, lineWidth: 1)
                )
            // Placeholder when empty
            if labNotes.isEmpty {
                Text("Add a note...")
                    .font(.appBodySmall)
                    .foregroundStyle(Color.appSecondary)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .allowsHitTesting(false)
            }

            Text(labNotes.isEmpty ? " " : labNotes + " ")
                .font(.appBodySmall)
                .padding(12)
                .padding(.horizontal, 4)
                .padding(.trailing, 28)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(key: LabNotesHeightKey.self, value: geo.size.height)
                    }
                )
                .hidden()

            TextEditor(text: $labNotes)
                .font(.appBodySmall)
                .foregroundStyle(Color.appFont)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .scrollDisabled(true)
                .padding(12)
                .padding(.horizontal, 4)
                .padding(.trailing, 28)
                .padding(.bottom, 12)
                .frame(height: max(labNotesMinHeight, labNotesHeight), alignment: .topLeading)

            Image(systemName: "line.3.horizontal")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appFont.opacity(0.2))
                .rotationEffect(.degrees(-45))
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .onPreferenceChange(LabNotesHeightKey.self) { labNotesHeight = max(labNotesMinHeight, $0) }
    }
}

// PreferenceKey to measure LAB Notes content height
private struct LabNotesHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 100
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}

#Preview {
    AddNewExperimentView()
}
