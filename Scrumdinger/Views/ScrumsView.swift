//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 24/1/2025.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase  // Return current view operational state.
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            // List(scrums, id: \.title) { scrum in // Use if name are unique
            List($scrums) { $scrum in  // use if name are not unique
                NavigationLink(destination: DetailView(scrum: $scrum)) {  // Array binding syntax
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scurm")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(
                scrums: $scrums,
                isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
