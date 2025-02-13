//
//  EditDetailSheet.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 7/2/2025.
//

import SwiftUI

struct EditDetailSheet: View {
    @Binding var scrum: DailyScrum
    @Binding var editingScrum: DailyScrum
    @Binding var isPresentingEditView: Bool

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $editingScrum)
                .navigationTitle(scrum.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditView = false
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingEditView = false
                            scrum = editingScrum
                        }
                    }
                }
        }
    }
}

#Preview {
    EditDetailSheet(
        scrum: .constant(DailyScrum.sampleData[0]),
        editingScrum: .constant(DailyScrum.sampleData[1]),
        isPresentingEditView: .constant(true))
}
