//
//  AppNoteEditor.swift
//  SSC_Lab
//
//

import SwiftUI

struct AppNoteEditor: View {
    @Binding var text: String
    var placeholder: String

    @State private var contentHeight: CGFloat = 100

    private let minHeight: CGFloat = 100
    private let cornerRadius: CGFloat = 16
    private let dividerPadding: CGFloat = 7

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Note")
                .font(.appSubHeadline)
                .foregroundStyle(Color.appFont)

            Divider()
                .background(Color.appFont)
                .frame(height: 1)
                .padding(.bottom, dividerPadding)

            editorBox
        }
    }

    private var editorBox: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.appSecondary, lineWidth: 1)
                )

            if text.isEmpty {
                Text(placeholder)
                    .font(.appBodySmall)
                    .foregroundStyle(Color.appSecondary)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .allowsHitTesting(false)
            }

            Text(text.isEmpty ? " " : text + " ")
                .font(.appBodySmall)
                .padding(12)
                .padding(.horizontal, 4)
                .padding(.trailing, 28)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(key: NoteEditorHeightKey.self, value: geo.size.height)
                    }
                )
                .hidden()

            TextEditor(text: $text)
                .font(.appBodySmall)
                .foregroundStyle(Color.appFont)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .scrollDisabled(true)
                .padding(12)
                .padding(.horizontal, 4)
                .padding(.trailing, 28)
                .padding(.bottom, 12)
                .frame(height: max(minHeight, contentHeight), alignment: .topLeading)

            Image(systemName: "line.3.horizontal")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appFont.opacity(0.2))
                .rotationEffect(.degrees(-45))
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .onPreferenceChange(NoteEditorHeightKey.self) { contentHeight = max(minHeight, $0) }
    }
}

// PreferenceKey 

private struct NoteEditorHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 100
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}

// MARK: - Preview

#Preview("AppNoteEditor") {
    struct PreviewHost: View {
        @State private var text = ""
        var body: some View {
            AppNoteEditor(text: $text, placeholder: "Add a note...")
                .padding()
                .background(Color.appBg)
        }
    }
    return PreviewHost()
}
