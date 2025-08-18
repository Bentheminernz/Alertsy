//
//  AlertManager.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

import Foundation
import Observation

@MainActor
@Observable
public final class AlertManager {
    public private(set) var isPresented = false
    public private(set) var configuration: AlertConfiguration?
    
    public static let shared = AlertManager()
    
    public init() {}
    
    func show(_ configuration: AlertConfiguration) {
        self.configuration = configuration
        self.isPresented = true
    }
    
    /// Show an alert with custom button configurations.
    public func show(
        title: String,
        message: String? = nil,
        primaryAction: AlertAction? = nil,
        secondaryAction: AlertAction? = nil
    ) {
        let config = AlertConfiguration(
            title: title,
            message: message,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
        show(config)
    }
    
    public func dismiss() {
        isPresented = false
        configuration = nil
    }
    
    /// Shows a simple error alert with a default "OK" button.
    /// - Parameter message: The error message to display.
    public func showError(_ message: String) {
        show(
            title: "Error",
            message: message,
            primaryAction: AlertAction(title: "OK")
        )
    }
    
    /// Shows a success alert with a default "OK" button.
    /// - Parameter message: The success message to display.
    public func showSuccess(_ message: String) {
        show(
            title: "Success",
            message: message,
            primaryAction: AlertAction(title: "OK")
        )
    }
    
    /// Shows a confirmation alert with customizable titles for confirm and cancel actions.
    /// - Parameters:
    ///  - title: The title of the alert.
    ///  - message: An optional message to display in the alert.
    ///  - confirmTitle: The title for the confirm action button.
    ///  - cancelTitle: The title for the cancel action button.
    ///  - onConfirm: A closure to execute when the confirm action is tapped.
    public func showConfirmation(
        title: String,
        message: String? = nil,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping @Sendable () -> Void
    ) {
        show(
            title: title,
            message: message,
            primaryAction: AlertAction(
                title: confirmTitle,
                style: .default,
                action: onConfirm
            ),
            secondaryAction: AlertAction(
                title: cancelTitle,
                style: .cancel
            )
        )
    }
    
    /// Shows a destructive confirmation alert, typically used for actions like deletion.
    /// - Parameters:
    ///  - title: The title of the alert.
    ///  - message: An optional message to display in the alert.
    ///  - destructiveTitle: The title for the destructive action button (e.g., "Delete").
    ///  - cancelTitle: The title for the cancel action button.
    ///  - onConfirm: A closure to execute when the destructive action is confirmed.
    public func showDestructiveConfirmation(
        title: String,
        message: String? = nil,
        destructiveTitle: String = "Delete",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping @Sendable () -> Void
    ) {
        show(
            title: title,
            message: message,
            primaryAction: AlertAction(
                title: destructiveTitle,
                style: .destructive,
                action: onConfirm
            ),
            secondaryAction: AlertAction(
                title: cancelTitle,
                style: .cancel
            )
        )
    }
}

