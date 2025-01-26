//
//  ScrumView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 24/1/2025.
//

import SwiftUI

struct ScrumView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            // List(scrums, id: \.title) { scrum in // Use if name are unique
            List(scrums) { scrum in // use if name are not unique
                    NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scurm")
            }
        }
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(scrums: DailyScrum.sampleData)
    }
}
