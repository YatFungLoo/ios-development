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
//        List(scrums, id: \.title) { scrum in // Use if name are unique
        List(scrums) { scrum in // use if name are not unique
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }
    }
}

struct ScrumView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumView(scrums: DailyScrum.sampleData)
    }
}
