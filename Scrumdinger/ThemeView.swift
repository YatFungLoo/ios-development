//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 28/1/2025.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme

    var body: some View {
        Text(theme.name)
            .frame(maxWidth: .infinity)
            .padding(4)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct ThemeView_Preview: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .bubblegum)
    }
}
