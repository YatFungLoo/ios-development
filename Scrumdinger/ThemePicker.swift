//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 28/1/2025.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme  // Binding values changes according to parent view's data.

    var body: some View {
        Picker("Theme", selection: $selection) {  // Display all CaseIterable themes.
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Preview: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
