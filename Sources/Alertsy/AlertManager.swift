//
//  AlertManager.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

import Foundation
import Observation

public struct AlertConfiguration: Sendable {
    let title: String
    let message: String?
    let primaryAction: AlertAction?
    let secondaryAction: AlertAction?
    
    init(
        title: String,
        message: String? = nil,
        primaryAction: AlertAction? = nil,
        secondaryAction: AlertAction? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

// MARK: - Alert Action
public struct AlertAction: Sendable {
    let title: String
    let style: Style
    let action: @Sendable () -> Void
    
    enum Style: Sendable {
        case `default`
        case cancel
        case destructive
    }
    
    init(
        title: String,
        style: Style = .default,
        action: @escaping @Sendable () -> Void = {}
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

// MARK: - Alert Manager
@MainActor
@Observable
public final class AlertManager {
    public private(set) var isPresented = false
    public private(set) var configuration: AlertConfiguration?
    
    static let shared = AlertManager()
    
    public init() {}
    
    func show(_ configuration: AlertConfiguration) {
        self.configuration = configuration
        self.isPresented = true
    }
    
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
    
    // Convenience methods
    public func showError(_ message: String) {
        show(
            title: "Error",
            message: message,
            primaryAction: AlertAction(title: "OK")
        )
    }
    
    public func showSuccess(_ message: String) {
        show(
            title: "Success",
            message: message,
            primaryAction: AlertAction(title: "OK")
        )
    }
    
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
