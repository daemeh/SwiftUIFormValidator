//
//  ValidationModifier.swift
//  SwiftUI-Validation
//
// Created by Shaban on 24/05/2021.
//  Copyright © 2020 Sha. All rights reserved.
//

import Foundation
import SwiftUI

public struct ValidationContainer {
    public let publisher: ValidationPublisher
    public let subject: ValidationSubject
}

public extension View {

    ///A modifier used for validating a root publisher.
    /// Whenever the publisher changes, the value will be validated
    /// and propagated to this view.
    /// In case it's invalid, an error message will be displayed under the view
    ///
    /// - Parameter container:
    /// - Returns:
    @ViewBuilder
    func validation(_ container: ValidationContainer?) -> some View {
        if let container = container {
            self.modifier(ValidationModifier(container: container))
        } else {
            self
        }
    }

}

/// A modifier for applying the validation to a view.
public struct ValidationModifier: ViewModifier {
    @State var latestValidation: Validation = .success
    let showMessage: Bool

    public let container: ValidationContainer

    public init(container: ValidationContainer, _ showMessage: Bool = true) {
        self.showMessage = showMessage
        self.container = container
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            if showMessage {
                validationMessage
            }
        }.onReceive(container.publisher) { validation in
            self.latestValidation = validation
        }.onReceive(container.subject) { validation in
            self.latestValidation = validation
        }
    }

    public var validationMessage: some View {
        switch latestValidation {
        case .success:
            return AnyView(EmptyView())
        case .failure(let message):
            let text = Text(message)
                    .foregroundColor(Color.red)
                    .font(.caption)
            return AnyView(text)
        }
    }
}
