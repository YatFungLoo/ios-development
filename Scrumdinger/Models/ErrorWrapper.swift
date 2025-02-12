//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by YatFungLoo on 12/2/2025.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error  // Error is a type.
    let guidance: String

    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
